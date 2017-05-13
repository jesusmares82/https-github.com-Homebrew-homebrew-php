require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 12

  bottle do
    cellar :any
    sha256 "8b10eef90bc8545efc64f594cfe919e7fb26efffb56c37e0c71dbee4f6a3c8c5" => :sierra
    sha256 "fd5c5849cda7edd0eb7a3b287dab09031a867dc2aefa975aa8fdc03047c8c193" => :el_capitan
    sha256 "4a3651ea9a5c8ea9b61ced471ebf985e7ae66281e8382c787b2cbf2daf8e09e2" => :yosemite
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
