require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55PdoDblib < AbstractPhp55Extension
  init
  homepage 'https://github.com/php/php-src/tree/master/ext/pdo_dblib'
  url 'http://www.php.net/get/php-5.5.9.tar.bz2/from/this/mirror'
  sha1 'd5dac90bc09f197b73b5bfcc3ca7dd6187f32e16'
  version '5.5.9'

  depends_on 'freetds'

  def extension
    "pdo_dblib"
  end

  def install

    touch "#{Formula.factory('freetds').opt_prefix}/include/tds.h"
    touch "#{Formula.factory('freetds').opt_prefix}/lib/libtds.a"
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula.factory('freetds').opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file unless build.include? "without-config-file"
  end
end
