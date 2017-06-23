require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 1

  bottle do
    cellar :any
    sha256 "eac05a7fa94615bddea56f78488b25ad7c4fd1da0bcf080ce9a9cde2b6f53262" => :sierra
    sha256 "569f44c1aa155efc5d85a540cd59b21faee90b0fed150022f9887027cb47e452" => :el_capitan
    sha256 "a369be5ca485171536143c1aa4aa23afdd79133bc18451aaa4134cfe6f7a9d3d" => :yosemite
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
