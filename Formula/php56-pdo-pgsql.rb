require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    cellar :any
    sha256 "13c6d1e38e75dfb68f1b2d3cbfc8898d969cba0690849a3ee22d79543113067a" => :high_sierra
    sha256 "c0cb02c0cbfa3955b357acb91b52c9f698a9dedd833a4ce44867dd3667745816" => :sierra
    sha256 "eb860532956a785e357fb77c40b365fec1a17891957154c1444ece4fb7a9e9c0" => :el_capitan
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
