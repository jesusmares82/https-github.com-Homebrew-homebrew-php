require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 11

  bottle do
    sha256 "d6f9ed4b937b9b4978c472c260adb4cce296d7bbf5d73937e8ef147640a8b4da" => :sierra
    sha256 "da6835e1beaf7166ed23f3942fc808c0658c706cb1324bb66c9376f3d0f4f5cd" => :el_capitan
    sha256 "6fec51715e99a2e9f6729f8845241a09c1d124df7d6cd52f8b823e91e1adce1d" => :yosemite
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
