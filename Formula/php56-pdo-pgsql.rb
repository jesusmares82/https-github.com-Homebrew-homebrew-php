require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    cellar :any
    sha256 "2180282541b28494eb05c67c466465d83d713c148615ee873a9a8abb6a9c460b" => :sierra
    sha256 "c10483edc3c22ef00a42e67df9e4edd511490c344f3ac3acf99dc7c784712153" => :el_capitan
    sha256 "9579228ee7cf96eec5866c250b0acfe12758e329d5822a7b4b8242a5a2801b77" => :yosemite
  end

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
