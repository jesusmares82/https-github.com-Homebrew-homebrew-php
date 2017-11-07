require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 8

  bottle do
    sha256 "5b7ed6ed544e253acc90b78b0b0ecfe45eb260323b0e7888579670c957921b39" => :high_sierra
    sha256 "93069175e073ae358a4d142ca14e37eca0c18f8b9e31e766bd172a00e4997bef" => :sierra
    sha256 "b8f183d7ee4d7045d6a124767a867d79200b140e6d0eace0732c68cd6c612ef9" => :el_capitan
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
