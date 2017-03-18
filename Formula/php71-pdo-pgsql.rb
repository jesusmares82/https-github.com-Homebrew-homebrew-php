require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 10

  bottle do
    cellar :any
    sha256 "cc4c155b5e502c017b14114b17fc91a817d81ed11a96912e047a4720b1cdd111" => :sierra
    sha256 "a1f4579efa2bd868e2dd315efa15efc0321228f3e2a5098d7fb13384a4cb373d" => :el_capitan
    sha256 "4a0f395fbfed44295d8cb57b49b687e16d03134b97e6e3a2581e723525fb574b" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
