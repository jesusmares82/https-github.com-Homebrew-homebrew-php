require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 6

  bottle do
    cellar :any
    sha256 "5cdab6c21a1d882630f62da5a67ac1896d53ac4d24da12c43137a2b93a97580e" => :high_sierra
    sha256 "8fce62476c385dc1ed8faf81377af44906815b8863f0527be7ed856bac385e7a" => :sierra
    sha256 "d919c78e55c90093479aa1e03d6997cec3367ff36cf27d78d68d347268a7585b" => :el_capitan
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
