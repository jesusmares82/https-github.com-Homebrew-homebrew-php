require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 17

  bottle do
    cellar :any
    sha256 "0b7c3d4ebb375f46b131ca51fc29e85d4a6e36085a35a59378079b145e2af641" => :high_sierra
    sha256 "04fc646bd86e49ad074362eb2aab44c64095ec649d30d79995575016cb41d864" => :sierra
    sha256 "327a44ba17135a03a634ea5325d9ab854cd05bdd96162901410d6bfe78cdae10" => :el_capitan
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
