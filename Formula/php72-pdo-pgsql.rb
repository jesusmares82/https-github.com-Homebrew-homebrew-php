require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 4

  bottle do
    cellar :any
    sha256 "dd0dcde3b0b6489329aa83850050807b28b4f605ee16a20e208512a5f3733a91" => :sierra
    sha256 "1732c54d062edc98ad261885f9a995f5ba9f42d47ad9ca1391a6bfabcb3b90ca" => :el_capitan
    sha256 "cdaacf532af336d628506a369ac8fb4c5a505c52b8e968218804b57851439a94" => :yosemite
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
