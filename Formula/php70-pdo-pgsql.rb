require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 12

  bottle do
    cellar :any
    sha256 "15eeb36302c9a78e5b7068aad54e9786cde1fa87929bb0159ea567665badf0f7" => :sierra
    sha256 "db6eba6743df89a0d5bc2f5a4d820d15d79a4100397b36fc489d81dd5b49221a" => :el_capitan
    sha256 "1ae3fb2bfe118932d5ceeaf00be9f59b050481f7a55be41701fca848bef68bd5" => :yosemite
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
