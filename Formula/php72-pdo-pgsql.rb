require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 11

  bottle do
    cellar :any
    sha256 "f8154d88b2ac5f59069c160f6c8817562c1dfa8a4fa0d0eecc3bc50f5fb06c7f" => :high_sierra
    sha256 "7cd5508439ddebf7f9f335dad75bce7e3ec4cfddb32d0d80d6cb76f3565e95eb" => :sierra
    sha256 "7873005584504e47939e746953b62b272e33aab08d2f7ceb343a325ba7673549" => :el_capitan
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
