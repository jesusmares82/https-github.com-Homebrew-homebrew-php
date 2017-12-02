require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 18

  bottle do
    sha256 "f7beef59fcaa7747a9e3f8e4bcf937c7f8970bb0be1dcd0b61809f1ca2eb1515" => :high_sierra
    sha256 "7dd5fc3f571c5a82829efdfe7cfd8b41e8f4eab11cb5e35dffed68f6552235a8" => :sierra
    sha256 "3c60e2183f216e2047bdfaeb0f289aeee85153e21e1b7c3100bfe12f44a98b15" => :el_capitan
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
