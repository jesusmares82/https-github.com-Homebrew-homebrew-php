require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.3.2.tgz"
  sha256 "f875d0f8c4e96fa7c698a461a14faa6331694be231e2ddc4f3de0733322fc6d0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "071e106df20196516e33a3a42c9228c732d9120615743aa9f73530a08bedf7f8" => :yosemite
    sha256 "a7e3f27a10844ad3dfeb59678730cb3b3e4bd8b58139d18a78756f9f4c933427" => :mavericks
    sha256 "a055fc17be63e2712874b984c0b75c382496430b5ba5346ef4d626b447877fdf" => :mountain_lion
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
