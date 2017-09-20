require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 14

  bottle do
    cellar :any
    sha256 "b56069f626f2d0aa862052823bd7ae86a5b59129623713221a3c6dd0441a4c80" => :sierra
    sha256 "02f400a5723b3aa612e30ce3683a0152875d8f0a2da46d90a3d0e54b21ae2519" => :el_capitan
    sha256 "c8b81217aa9623a8b143a91d7d7d6c37ab45010e6b3f96e2d712c82369fa1bfc" => :yosemite
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
