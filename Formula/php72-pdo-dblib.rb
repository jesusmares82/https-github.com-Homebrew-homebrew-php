require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 4

  bottle do
    sha256 "9df50404bfcd39d8cb8d7f8c2843677264ad545d34ad4c1c6337d921c8dfa066" => :sierra
    sha256 "5c72d6637e2caf149635ca44055aad4c4976aa71a7757ac0adc376a53215466a" => :el_capitan
    sha256 "afa091aa11388755277cf52e9608682eebfd61970d3aabe27855d760d774e10c" => :yosemite
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
