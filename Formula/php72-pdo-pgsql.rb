require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 7

  bottle do
    cellar :any
    sha256 "88079bc7465a3b4938f400d513f7c1f0da9c826003fa02eadd76c2405860433c" => :high_sierra
    sha256 "9b2144abdeee51d661dc32217e29571adf75e9017fcab2d204de3738ee78715a" => :sierra
    sha256 "d9bfebf58e0210d63c87b8baab0e2e8726a000b7132fe847079df93c10b0d478" => :el_capitan
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
