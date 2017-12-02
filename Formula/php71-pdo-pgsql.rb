require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 18

  bottle do
    cellar :any
    sha256 "413eb320d957b0e28680b7043b0b1b82fdde0983ba1b74b0440705429e3ef893" => :high_sierra
    sha256 "fd66544f9a4f001f18115a433c54b4732c2ec015b925fef63817d803640daa63" => :sierra
    sha256 "13f6dc2e6d5ecd39c01db0268f5d224596f410b9eaf42de57b11265d7bcda300" => :el_capitan
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
