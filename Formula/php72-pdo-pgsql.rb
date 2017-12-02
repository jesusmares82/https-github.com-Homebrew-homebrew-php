require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 9

  bottle do
    cellar :any
    sha256 "91f64827376f6b8e26c2630b2bdeb54fb5d9ad77a0b17226d156015a332dded1" => :high_sierra
    sha256 "20e68f2eb6830895250d887f8d370a72e58cffc59f813e88abe8fd250cfb5251" => :sierra
    sha256 "c15d16ed98b6f96a439a1b17a3274bf1683087b63c81327513ef6c8859312f2e" => :el_capitan
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
