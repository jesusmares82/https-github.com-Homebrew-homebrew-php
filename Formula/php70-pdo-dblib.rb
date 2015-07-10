require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "515c4548522c6f6e23ec5741fed01a175ecaaf332eafc7f6ca073c5e3a420409" => :yosemite
    sha256 "7619017a13cf3de82ccdfe64fd477dd89b759f1b544728c86a38f9fbbfe414c3" => :mavericks
    sha256 "b69cfae8cd648373014cba7842259525b44e96a1cc7dbcf5f01c9fa85ee50da7" => :mountain_lion
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    touch "#{Formula["freetds"].opt_prefix}/include/tds.h"
    touch "#{Formula["freetds"].opt_prefix}/lib/libtds.a"
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("pdo_dblib")
  end
end
