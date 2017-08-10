require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    cellar :any
    sha256 "05b35daefeb467f5d151646c7ae6982d1f9b94e0dcf53ef189eb213152b5080e" => :sierra
    sha256 "cf3078a825df64ae51fb7557bd4fed5c5951f5f5d473fd92500ed6450f551f2a" => :el_capitan
    sha256 "31ec0fbaa666bf088ac5427452747f843033b6b1683571275741317c670d33ec" => :yosemite
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
