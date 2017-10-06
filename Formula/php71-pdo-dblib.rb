require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 16

  bottle do
    sha256 "9971d990e14bd6d025334d906c1e6ade14b6969917203bcb1dca361dc44ec650" => :high_sierra
    sha256 "870c57ecc6424a86e010698c86863a6183f26df403e3ee88df44800fc4739958" => :sierra
    sha256 "1f5f72abc38212e7c4549c15b2a08c5fbfa91bcd7b8c525506e0628121414b8c" => :el_capitan
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
