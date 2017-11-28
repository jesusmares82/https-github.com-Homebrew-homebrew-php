require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 17

  bottle do
    cellar :any
    sha256 "c04b2bde8154247c726cde31ba5912abdd8aea5d12d15abe19befd7e655fcb8f" => :high_sierra
    sha256 "946403127acf4867814ce4cc8ac6943b30a18b3d5f5059d33196d521399c350c" => :sierra
    sha256 "f36a35da89dba7fcec7adfffd46cd98c81c0af3a5a2676591e3a7e8b036b2e1b" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
