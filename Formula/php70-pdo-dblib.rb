require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 7

  bottle do
    sha256 "7a91861f3b89ba6521bbc9951ac246421a47e9bd1e26d9a9213b184714dfc3b3" => :sierra
    sha256 "2ef405dd1b321d33c03084ae43f14e78b2277fdef471eae219f27ec4f798d854" => :el_capitan
    sha256 "d65dc43e361197f1d7827d7ac1c72b1ab4476828313626607858aa3047dbeafb" => :yosemite
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
