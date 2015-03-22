require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.3.2.tgz"
  sha256 "f875d0f8c4e96fa7c698a461a14faa6331694be231e2ddc4f3de0733322fc6d0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "e4ff7c329bebfa36b6b4928e921406bd52a409e305e3c16e4e274f7192183f29" => :yosemite
    sha256 "67f008565112b1215215aee47e1f5075d4cf429e1a7368c4fa8a5e36954ecf74" => :mavericks
    sha256 "2e82b63b25bc024e4b7555365f37501733a10e487d887855be22a107f33380ce" => :mountain_lion
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
