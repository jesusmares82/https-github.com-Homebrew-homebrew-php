require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 8

  bottle do
    sha256 "d0079e0aea131053e20286050979708914d17ba962a6231d41490253b1b53b6c" => :sierra
    sha256 "fee98790fd644430626fadaef4f6b85b5da8e273d5ea681880c4f6e997fa4db2" => :el_capitan
    sha256 "cb1dc6ce66ad6ff4c4b2845a598f69ff9bcf0816632eb3777a1a1d45562ad14b" => :yosemite
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
