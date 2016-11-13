require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 6

  bottle do
    cellar :any
    sha256 "e28770fdf7aac4876cba42a2504b0d563c894acf17862b20c83801e0db5c185d" => :sierra
    sha256 "42961e24626389fd916208633e66f97ec8eac8819059ea57f1c154fa4040bc76" => :el_capitan
    sha256 "e472589d5a5896bd48edfb3413ee612bea5a5f51dc9ddd4babf889b8515d2d6c" => :yosemite
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
