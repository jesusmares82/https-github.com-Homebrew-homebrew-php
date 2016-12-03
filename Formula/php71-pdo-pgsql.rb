require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 7

  bottle do
    cellar :any
    sha256 "e13375b6fc09fd0809ed41ae434269ba16472bd54db5c3c2c58b05cfa93c0ace" => :sierra
    sha256 "c6053a15433ef064ac0080feacb52b91d173284bb0ebc427a0fbd2694af0344e" => :el_capitan
    sha256 "bd7add8de0c80dbaac4e8ce55fd3ff2e4bcdc8cd925a68648c91dac7107eb46b" => :yosemite
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
