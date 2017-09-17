require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 5

  bottle do
    cellar :any
    sha256 "cdfff8cffdf193e9d433a9d04d7952c947c37e3ba19b438c792ca46ad176bb85" => :sierra
    sha256 "99a82f7cfdbcf362536ce9e1673941ae69149d16ff1a20c5fbba579ff6086e7a" => :el_capitan
    sha256 "293f72669caf669a487678c6f53d7c2e1ca3258d9877d66090ef3802a40b714b" => :yosemite
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
