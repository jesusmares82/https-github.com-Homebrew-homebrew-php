require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 6

  bottle do
    sha256 "ddd92357062d63e942bdcc277bc61b4faa159c6a36291ce96326011e25f989a4" => :high_sierra
    sha256 "dbaf5dfc3a4eaa2ad2d0d5635adcd6ab83d553e19aa6af3b11b7f9c5d2e8ef82" => :sierra
    sha256 "1fa3f1839f273edd2d50917c594dc7ebacf2e53bbf1585f4677fcec61c58a497" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
