require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 5
    sha256 "342e7e535ab301584feb6db120c921a2b7226eebe04a0c7e45e0e3a6ae0b2ed5" => :el_capitan
    sha256 "4199eba6a4cda7953d2337ec39c72abb3e9c1a7b0d6d6e8688b0818d0a1f5cae" => :yosemite
    sha256 "f9f11bd2a717cf27eaacaf25e218212e627579feef525c72db3a83f9f0c2ed1d" => :mavericks
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
