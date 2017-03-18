require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 8

  bottle do
    cellar :any
    sha256 "f103a51639778a197ac9003827929415d5bc00b2811a602e4948c79426ebe20f" => :sierra
    sha256 "4f585d1ad3e3b1b60e49c671df2e9d03954dbf2c0718a04dec06b23f49493aa0" => :el_capitan
    sha256 "45b2262b42a4345a989f6715d12267fd7c5dc0a5919277bc3581fdd9ea7e95c3" => :yosemite
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
