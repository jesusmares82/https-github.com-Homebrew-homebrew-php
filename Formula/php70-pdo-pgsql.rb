require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    sha256 "c428850111cad8d4169c7f4c38001c12ebf0e48000eac365bf9833db45939d5e" => :yosemite
    sha256 "63a89730f174962d207744e5c271cfa5f786694c86eca2d8519cea688062c122" => :mavericks
    sha256 "7a69e313c53cc9e6423dfffac244971394278df18f6b073130988920ff18b798" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pdo_pgsql")
  end
end
