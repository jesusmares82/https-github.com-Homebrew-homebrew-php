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
    revision 11
    sha256 "07a51cb9ffb0dda8a2c2b1d44dadda31ba1bb34584925c0b0e7f483b6f09a060" => :el_capitan
    sha256 "3a0ee4533f8a2cad225ea9787a58e60c81e3487a5e4d26e6379df8a8aaa9832f" => :yosemite
    sha256 "92624b67352c837f1b28ea512d489636578583a85206e043bd5ea12820eb607d" => :mavericks
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








