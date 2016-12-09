require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 6

  bottle do
    sha256 "9460347f4a2d34d24cac68e76a82e352bd63a3f15cf04cf09f0f49e38e039481" => :sierra
    sha256 "9b04c96aa826440010902f1ea1362b46115f4060592c3793fa9cd63ebf1063e6" => :el_capitan
    sha256 "e149e864551962dd372a617fa2edd735b2f9ef7d67869fe1a4bacca25ccde275" => :yosemite
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

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
