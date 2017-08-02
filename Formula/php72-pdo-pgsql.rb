require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 3

  bottle do
    cellar :any
    sha256 "c4423790963937592a1a8b2753df5324caeb94e01daebe6d6f8acb60fa83396d" => :sierra
    sha256 "0ccac70b49ac74e89a79f20f2bcc203218582fd5914e63bf6d9b41b30d7b368f" => :el_capitan
    sha256 "566a0ee19f18cd14522e42cd3d324f9ba7cfb93589befcd7deb76eb6165de3a0" => :yosemite
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
