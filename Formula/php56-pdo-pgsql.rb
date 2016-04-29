require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 8
    sha256 "7787cf1f42242630e787a91dded21290fbf712f053c97d7bb6df18560ef9d7ef" => :el_capitan
    sha256 "556e15b815ebfa7b7ae6631b1785a3d859045bfcbbce24b09616a457eb0d90af" => :yosemite
    sha256 "5fbd2513a1970be34cd9aaa2e2bd8429f859d28ef042665429343f03ba555de2" => :mavericks
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





