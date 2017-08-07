require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 15

  bottle do
    cellar :any
    sha256 "88c8d11d40fd6be82f03ba38fdcf10a35f5604048b545ac6a6c726c91e21ba01" => :sierra
    sha256 "5961c0ebb6c8a260c4e0ea6cae63de9eeaf38228ceee74ade6583bc453e3f174" => :el_capitan
    sha256 "3c539f854a670edecea97d7eb82228d37fd78cd82c5e5857d2dbbf415291bf8b" => :yosemite
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
