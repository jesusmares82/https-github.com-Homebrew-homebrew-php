require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    rebuild 12
    sha256 "fe23af9ea7d638accd58e91fc58673183d7bfe3202ed068d3f91c8895fd4479c" => :el_capitan
    sha256 "cc54306e50baec8a4bebfb6a115924602b744fd6f94246dd8b613e4bdd25d7b2" => :yosemite
    sha256 "e138fb3a90f1f14bd3e87a564d6d58cccb9d6c41a3923597e00f3e0528d0cd32" => :mavericks
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
