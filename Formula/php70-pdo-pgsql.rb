require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 6

  bottle do
    cellar :any
    sha256 "71d0b607b330279c0003b4b465ae86fd367e648955f947fdf7c53b7ceaf838f5" => :sierra
    sha256 "4827396cd1a9e04e4a733c51a16061482d80d4e46f01f567072fd8c388f635a3" => :el_capitan
    sha256 "5ef9e9d9a90b4f8e449ddda468ad5af0878f07bc307d88a39ea6b431724e1393" => :yosemite
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
