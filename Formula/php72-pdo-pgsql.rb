require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 11

  bottle do
    cellar :any
    sha256 "f3e5c5a12a5412bb38d8b8e9ce62650d7bb8bbca64d4346299aec00cd50e6464" => :high_sierra
    sha256 "4099cddf2acc7bb1d317f25b5e4349177d4c6037cf7581158ea27eb65be289fd" => :sierra
    sha256 "5b40f54303a312f8433b2b239062699aa2e1311bdb2bf07cbc66732f286777ba" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
