require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 19

  bottle do
    sha256 "9dc4341d88f88a98cf87f676e92bd22973dc70dd2fa92afb9ca822953b710845" => :high_sierra
    sha256 "8d7428b2d41b7df2dbfb4417f51eb3aea1f57d03ecd683c03f3dc173bbd65cc8" => :sierra
    sha256 "f007be0b8b1899378122afb813fd74f563fd0a08270ac7ecaaa503aa16076661" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
