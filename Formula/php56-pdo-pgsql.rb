require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    cellar :any
    sha256 "4b6972acbdd9eaa63def1bd3b90247b53d493d8105950fbb3a4a6ef681043531" => :sierra
    sha256 "a79c87ee0294bf4b289a1318e1fa5b93afde89d08d5f5142e71acce2d722268a" => :el_capitan
    sha256 "85b6da44886a3724712d5a3bdf2c19978c908b030ddadfd63eb49564feab26b4" => :yosemite
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
