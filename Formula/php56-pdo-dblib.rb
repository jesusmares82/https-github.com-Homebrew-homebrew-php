require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "63fa779c8e9545d33a376e4414eb7bb188e1e9ff83896de5fd8c21a732a5e020" => :el_capitan
    sha256 "0bf0ba9b8a775db2b94c087e8a5ca798fe68eed0744d8bc199a878f6b017d866" => :yosemite
    sha256 "7bb36da5e2002434559afbafdf6738826c11f44b7ff5b5ff22e2a454c2e295fb" => :mavericks
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







