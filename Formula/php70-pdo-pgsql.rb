require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    revision 4
    sha256 "3e1604789b838f68028fd254d6ad105c0c0e4f6b6b0669170c70d9ceb4dacecc" => :el_capitan
    sha256 "32edd578a68131ca26c039f7ddfe4f41c6ceedd4359847de523851767de33cde" => :yosemite
    sha256 "37b10b33cd0ecc37d584060ee23119dbfbb7bea398087e5a05f80c233f5c7f3f" => :mavericks
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
