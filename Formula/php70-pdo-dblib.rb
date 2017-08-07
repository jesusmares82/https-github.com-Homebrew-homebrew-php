require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 13

  bottle do
    sha256 "294e9d3acd24fef4611b216c0ba3477b3c21df03aa1ccbc2632eaa25e33fd6ef" => :sierra
    sha256 "549e687b40923a8228bff58e1a44a682e25998020e5395c46a9831436a30e9bb" => :el_capitan
    sha256 "053cf20b69b088c5fdac1720abc053678feab73c0f5cff125ca834df430b77cb" => :yosemite
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
