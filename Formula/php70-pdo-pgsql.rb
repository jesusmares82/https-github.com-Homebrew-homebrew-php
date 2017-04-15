require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 9

  bottle do
    cellar :any
    sha256 "3c5e378fefe81ea21e061f30e3b1f85c6c29c9f4e045a3e88d19438b6925ce23" => :sierra
    sha256 "00976cde9f8357fe9940972e915ebaa85fa3dcdd665532b918c9c2aa48844122" => :el_capitan
    sha256 "17e0a3288866d390c3538fd95132338e14a157b5eb8989cbc12ee111c4d93729" => :yosemite
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
