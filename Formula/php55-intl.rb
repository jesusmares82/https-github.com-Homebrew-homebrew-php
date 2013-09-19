require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Intl < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.5.4.tar.bz2/from/this/mirror'
  sha1 'fdc6724a7a3f23f7c87a3470e5b29d260685e2b6'
  version '5.5.4'

  depends_on 'icu4c'

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-icu-dir=#{Formula.factory('icu4c').opt_prefix}",
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
