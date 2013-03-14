require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Intl < AbstractPhp53Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.3.22.tar.bz2/from/this/mirror'
  sha1 '8a0948040d70bd7ebf1f3001c4462649b43d5ab0'
  version '5.3.22'

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
