require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    cellar :any
    rebuild 12
    sha256 "faebcef129d9ef2e690390da24111bbc90b8201b3e5e2dba666cc6e0ab49172c" => :el_capitan
    sha256 "2b890166564c108538cc41968bed08f8d59255f76beebe7b1ef7ed2d77198e5a" => :yosemite
    sha256 "59b9a3770ea30bbf627fe59c99a5cbae3918cef86c6a87f75af5b4e538be466f" => :mavericks
  end

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
