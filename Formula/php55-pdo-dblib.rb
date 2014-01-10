require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55PdoDblib < AbstractPhp55Extension
  init
  homepage 'https://github.com/php/php-src/tree/master/ext/pdo_dblib'
  url 'http://www.php.net/get/php-5.5.8.tar.bz2/from/this/mirror'
  sha1 '94800df241864a2c66fd01adca3d22247dc1a8d5'
  version '5.5.8'

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
