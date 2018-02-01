require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 11

  bottle do
    sha256 "ce3182ec3feed62ef095ec19676264b7c81122db31ef02a6c30aa2565e7add5d" => :high_sierra
    sha256 "da80c658d40929c0a6075d0b4c6cdc48a608b3d4a12fde65d85cb3d288dc068e" => :sierra
    sha256 "64679db55ce28dbd5b30536ea7e7571f3a3eaa8f454bff7ba5b3ce514b383c60" => :el_capitan
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
