require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Uopz < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v2.0.7.tar.gz"
  sha256 "aca7dac96c00e5bd628625ad7372d733c8a40a48d4b143d7f001feea1c5fb3b1"
  head "https://github.com/krakjoe/uopz.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uopz.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    caveats = super

    caveats << "  *\n"
    caveats << "  * Important note:\n"
    caveats << "  * Make sure #{config_scandir_path}/#{config_filename} is loaded\n"
    caveats << "  * after #{config_scandir_path}/ext-opcache.ini. Like renaming\n"
    caveats << "  * ext-opcache.ini to opcache.ini.\n"
  end

  def extension_type
    "zend_extension"
  end

  test do
    shell_output("php -m").include?("uopz")
  end
end
