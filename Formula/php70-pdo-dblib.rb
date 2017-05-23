require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 10

  bottle do
    sha256 "bf1f2ecf8ed0b3cc254d6c2b208b76735e828a00dfd99ee52ced67e39eaa9180" => :sierra
    sha256 "95923d3c1b6515ce4109dc509a8c1f25bf518db7eb9a342b3a1d1470bb68fe74" => :el_capitan
    sha256 "fa406e557832ac80101aeee8f957bb9cdccd57958e64a91de29ab371d267b99d" => :yosemite
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
