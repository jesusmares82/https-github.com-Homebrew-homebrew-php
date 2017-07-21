require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 14

  bottle do
    cellar :any
    sha256 "c10ac7c5864cd503b658f499029307fc100cf873a210e4cf25f8df5d8b4465ee" => :sierra
    sha256 "75d77236a419eba454929fd023eed724a271a1540e5a9ec51f7ffc7f49e8cae2" => :el_capitan
    sha256 "6a35f872a42d94ff1cd98bf2b50aed765a6340fdff6b1ac4ff25e03c4ff253bc" => :yosemite
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
