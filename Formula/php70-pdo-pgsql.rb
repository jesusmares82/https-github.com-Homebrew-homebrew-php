require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 16

  bottle do
    cellar :any
    sha256 "736cba354964832be7948ece8d53004b8b2ab751e1a993fe197339aacd2ac655" => :high_sierra
    sha256 "54acd57d2265b7fb9879af7d4f3db268f7c405e0b652de10ae0989c6b38313b6" => :sierra
    sha256 "ba9494d94d77e0cb8fea2d9cdfc19f73abc9f92624ea68be1c5b451a0e382c95" => :el_capitan
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
