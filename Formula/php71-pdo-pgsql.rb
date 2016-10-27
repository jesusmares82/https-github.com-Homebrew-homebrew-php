require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    sha256 "86307c79154fa0cef0f6c46eaf655030ac37b9170b1acf846691ab6593f2258d" => :sierra
    sha256 "33a266996deec3960b1bf374c898f95c1f2f0587a4717a488a6736ba998ae4a4" => :el_capitan
    sha256 "494dc1c02bea911d8438b0f1aab5a17f99a196f0df6bb12de7c8ed6abda29433" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

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
