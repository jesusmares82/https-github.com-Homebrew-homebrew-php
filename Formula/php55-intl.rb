require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Intl < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.5.5.tar.bz2/from/this/mirror'
  sha1 '85b9db72cb6af5612703aec45deba4262eadbb1a'
  version '5.5.5'

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
