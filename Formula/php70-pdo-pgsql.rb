require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 10

  bottle do
    cellar :any
    sha256 "a423b52607b3644b66d69ad779129674804ce1467d27a60315d325d7399422ab" => :sierra
    sha256 "7dd6242907e7d66a93072dc21b4d1bf7485f91c4d1631bbf8b4e42c3b18b9051" => :el_capitan
    sha256 "6cea37cea51589dbe321e97acb9411c5696c6136e63340c9fd6d98cef8eddc59" => :yosemite
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
