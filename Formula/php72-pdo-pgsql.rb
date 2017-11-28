require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 9

  bottle do
    cellar :any
    sha256 "09e7f29fc7d094a74e44bec345a0a9a1fdd7aeeb95805986b520a2544e749f64" => :high_sierra
    sha256 "51744cd09c41817c87530aaf17e14e52223ba7bee18982a8d6a011bed662094f" => :sierra
    sha256 "c22a28a379a504c13586166927a2ae9f03910910b056cffd055bb142b927bd43" => :el_capitan
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
