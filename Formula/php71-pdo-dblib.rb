require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 11

  bottle do
    sha256 "97286c907cabbaed10ac5f8f915d7969d8433843e40e0fd11e7d400351673999" => :sierra
    sha256 "a9f82f8fc76e479d2aaf57962a20c68bb5b6504c6fe3321c6b58303b5252cf6f" => :el_capitan
    sha256 "9a20113267b0b92e4dce59197b9c23bc1d8e2fdb83b2851251935003600ee649" => :yosemite
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
