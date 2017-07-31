require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 12

  bottle do
    sha256 "cd26cfa3f891703b8f4affb83fecc74ecbb2c5e79fadaf8dcba5d3f179f325b7" => :sierra
    sha256 "5f8b455f689af83a095dfa3d052b1d8f681a7867150984446d4f3e9d64fca6f4" => :el_capitan
    sha256 "e76a7d5ba65459ef4bfc02bec775854f994a5f6edd5a302e07bcab4577b2e29f" => :yosemite
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
