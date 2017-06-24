require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 11

  bottle do
    cellar :any
    sha256 "6aa2c65e94ae65149eb5159154c8f9a34ad16795033f7ed7999cc4224a438dbc" => :sierra
    sha256 "0fd8293247166b66d17b80bf4a843d5243572545d08a06aed2247eec9effd0c9" => :el_capitan
    sha256 "71b253773bedb6ecb980a01c396176552b7061eaee8996bd1e9025b0d0b99a44" => :yosemite
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
