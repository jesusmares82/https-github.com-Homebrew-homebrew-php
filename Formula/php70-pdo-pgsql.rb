require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 10

  bottle do
    cellar :any
    sha256 "20ea09f4dd625e43c0e7110f37c220043447af018f95289a4fe2605f2396303a" => :sierra
    sha256 "506371e06b13a18d225ede9b95bce0cf46431274ea4bb13b006c39e7d8bf431e" => :el_capitan
    sha256 "6ec10f7b6e6fef58a99819b508d65a000dac388c2cf05c3f38ae68ae00e7d33e" => :yosemite
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
