require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 11

  bottle do
    cellar :any
    sha256 "54c08596ba72a3aa7cf2e085c538d483ca1f4e1e6be246e077275b2f2796ea09" => :sierra
    sha256 "f2255734c3b1c57cffb091845a2a2a43ee8548dbbfd16f4a9c06d51b92d1ea5b" => :el_capitan
    sha256 "c838103d89029bef889caa9b0367eefb218e7ca58b24aad17350f80afb75c26b" => :yosemite
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
