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
    revision 4
    sha256 "a238b3179bb4a95b7bbffac193f5fc51da541d71f9cf34efd028d6ed9d9b2412" => :el_capitan
    sha256 "d4b1a666bbb6fe6952ecd6fcbe65d567a80fbef9dae013699caa8989ec442e9e" => :yosemite
    sha256 "d1342c46844c88f9cec8e03f54ea8aaad93fb9d75295d69ba941e9d6062e7ed6" => :mavericks
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
