require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 1

  bottle do
    cellar :any
    sha256 "90851f584f83e9010f460feb952f19d5cba7beaee281982be3f4a16828dff80b" => :sierra
    sha256 "c8028792de326b82b2a39075a58f9d82b17eeeb409c63d5514d527a906aa8be9" => :el_capitan
    sha256 "ed90741992c0f4d6cc0ca895b1bfe73f4ad69d014dcf7bee78d20669d5d6a60e" => :yosemite
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
