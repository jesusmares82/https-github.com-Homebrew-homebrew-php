require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 10
    sha256 "b8d4c35cbcdd04643e2c03e772de40ea80e7fd549e915d559e5749f7671a5615" => :el_capitan
    sha256 "6ff8f9d9bfba3dcdee92e3fddae08785e0fa156f2b3158f4b41fa59b944b5547" => :yosemite
    sha256 "1795ae1a79fd4fd48f9690ac64ffdad8d214ab7b843ac1264cf6a0bf6dc199e1" => :mavericks
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

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end


