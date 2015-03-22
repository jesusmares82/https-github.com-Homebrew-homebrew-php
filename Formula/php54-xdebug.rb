require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.3.2.tgz"
  sha256 "f875d0f8c4e96fa7c698a461a14faa6331694be231e2ddc4f3de0733322fc6d0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha256 "e67ec936b6d5b494c21ebc9ccc40594ed2c58e0dec79a3fcc594a82d0b8fb8ff" => :yosemite
    sha256 "d7a254d1ce4e315dedccc557befa5c11a3fdfc20283d3652be001bad15fcac34" => :mavericks
    sha256 "87dc25f4838c74bc3341d57238deff419f5f255ef7d96a1f8a8bea0eb6567411" => :mountain_lion
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("Xdebug")
  end
end
