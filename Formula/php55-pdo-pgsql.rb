require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 5
    sha256 "e95415110313fd33dbf60561ddfbc23289f89d1b5eee0f8524a8ee2c86fabeac" => :el_capitan
    sha256 "fafb71b3fa92f15d5f74b3e8942d0ea0a421b98c5209091b0984a53f6ce5d83a" => :yosemite
    sha256 "f5e51a08280a54299c39f465e7b197366e48f869ed07a1c0761005e76d5431ae" => :mavericks
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


