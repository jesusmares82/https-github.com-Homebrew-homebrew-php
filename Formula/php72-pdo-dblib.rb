require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 5

  bottle do
    sha256 "18ceb50e5f00e4e2e24f35cbe11e8022026a6005f23b34b943ff429861624693" => :sierra
    sha256 "82b3f632c1d877c421d7803d056c92c33c66e1902d2305c7b05dd76b0c6d861a" => :el_capitan
    sha256 "4520398d2183634703086b4db6e37a260b011c8d7e2f3f1870f384e16db9f4b7" => :yosemite
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
