require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 1

  bottle do
    sha256 "4ffda737c3c3cc6ffc6b62b86d4ce96c890a8a1531c5fa046a2f3be6e5550552" => :sierra
    sha256 "e5d2cfa6c403585c70dd20b0d97f687e6959674cab8780dc8b51dcfb1df5a5df" => :el_capitan
    sha256 "0dde9d28fc2d321fbb3c6613a89bbe396d724caec781f22669e62ca20835ad2f" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
