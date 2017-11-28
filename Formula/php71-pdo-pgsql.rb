require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 18

  bottle do
    cellar :any
    sha256 "778812f367769ff3a29a074ce7a79536725df33036536229820f7611a26c0c0b" => :high_sierra
    sha256 "ad0ec26d90f0ba845b0b30869fe0eb0291c85123079d5d86cafa9c1e3fd719c8" => :sierra
    sha256 "b9391908fb6bc931479f5e3acb3d9aa79c70216ce58552cf0f2e3f2f591750be" => :el_capitan
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
