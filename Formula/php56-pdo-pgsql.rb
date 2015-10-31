require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "b20cbe63e43b068dd22c06e8dc4dfb4b1aafd664ff3b392238125433cc57f252" => :el_capitan
    sha256 "69277c04d19ed39543e141b19c34cd7ad64dc66e63b843a1b75d119c03e99617" => :yosemite
    sha256 "0bd6e2f4fbc8e0b779b99303bdfe5349d1470d691ee62f2d3835cb18675923d9" => :mavericks
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
