require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 10

  bottle do
    sha256 "de6352b0f7c77062b6fe9eb40cf6730a99da6bafb38d10c9bce7b4e3f0a9d215" => :high_sierra
    sha256 "3ff23fd37cb2c7d98ea31a85718dbb6e13bcb2bad4b0472046546bb43bc91fee" => :sierra
    sha256 "f45e6325b5a0e02641c46dada6453bdee48c89734582b002fc1b08784fe35170" => :el_capitan
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
