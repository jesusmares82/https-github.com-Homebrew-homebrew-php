require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 8

  bottle do
    sha256 "11e0919279cab6da5f353e20eb880bef000b8f2b114fedd52e040e23bffaa3e7" => :high_sierra
    sha256 "ab377c54e531f1d2224fc7386ed704fedfe0845f12f26f8cd61288566db45b25" => :sierra
    sha256 "1d529ece86116db9c6233e11edca8732aa0d86359a89c2f7293cfb6bf2d45420" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
