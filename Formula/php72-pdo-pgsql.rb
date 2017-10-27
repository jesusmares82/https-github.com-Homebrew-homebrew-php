require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 7

  bottle do
    cellar :any
    sha256 "d1315bc90f57752c6e8f25f01ecb65a97714bc7b4cebfd275a60582bea14bee8" => :high_sierra
    sha256 "10974547d452d51869209c936a14fbceacb9b1aeab9c1a88845ad62e56bb1746" => :sierra
    sha256 "eff298cb46c488a3c3d247b3d108677525cdca729da4343550d6bd56255d4ad3" => :el_capitan
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
