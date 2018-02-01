require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 11

  bottle do
    sha256 "b0ee1f3ec8b1e0d1f2c66b9ac41c813c76bedee5fe1d56c86870bf8dad67c5c4" => :high_sierra
    sha256 "6a3eeb5abe872f2a1fe6f28feaf66fb08126901b3b4b52af3b5c04e020a96241" => :sierra
    sha256 "d6f9a582ebb0c07111ada60e8693ad1c29f2218bbfd0df7fab3de276c1187b7f" => :el_capitan
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
