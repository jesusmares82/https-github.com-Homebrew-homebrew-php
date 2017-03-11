require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "80c359c7dcc4664bcf07f7ac2bec766fc8345d0bbb3b17d4a9ee6f29f8c7ddba" => :sierra
    sha256 "4eca372f1bedf09eece6640ce5f7d959f2fa224f583529ecc923bb7ad43abb77" => :el_capitan
    sha256 "c8e6935ae377be2830584c9133297f341bc8da2b2b74ef7afd08d9dee58a94a3" => :yosemite
  end

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
