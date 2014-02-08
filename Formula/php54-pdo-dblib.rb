require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54PdoDblib < AbstractPhp54Extension
  init
  homepage 'https://github.com/php/php-src/tree/master/ext/pdo_dblib'
  url 'http://www.php.net/get/php-5.4.25.tar.bz2/from/this/mirror'
  sha1 'de42bf7c55f6b16e29b01ada24d9d5055e89a2a7'
  version '5.4.25'

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
