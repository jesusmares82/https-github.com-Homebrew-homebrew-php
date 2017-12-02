require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 17

  bottle do
    cellar :any
    sha256 "0e4d3a3b416cf4be09828ed21e839a52546092f15cff6e37a91a494a0fbe1523" => :high_sierra
    sha256 "2427164878d24336ec4237d5f4523fccf3b4bc78568eb193b4544662ef2277aa" => :sierra
    sha256 "b915761152ace70a0aa2c66974633666cb65776613ab039c5b05a65c962f648d" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
