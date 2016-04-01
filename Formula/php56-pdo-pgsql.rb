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
    sha256 "32d5238ca4d3dd436dcaf4acf90bb7b7261b458a583107cb231e8f9b01501b7c" => :el_capitan
    sha256 "cbb8f3befb4956371168cad0087c6da8b69697baf9d6d418d734195424744f7d" => :yosemite
    sha256 "60aeb43eb7a54476627d62d8dd834c0e9b27a34cc09bb842ae0b3ab655eb3ae1" => :mavericks
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




