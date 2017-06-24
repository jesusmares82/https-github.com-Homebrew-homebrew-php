require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 11

  bottle do
    sha256 "5ac69c7131ba68fc3184289e40d30d78a8530bf8f0d8061b8332f4a7008b1074" => :sierra
    sha256 "b080d0c320a76b85cc449956217874c6c05b98bea34c58c01fb616e17e7b9a95" => :el_capitan
    sha256 "6ad90deab28fe8312e63c8cfc856fdcc94edf3c47fd5be58debc9ed49cbe064f" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
