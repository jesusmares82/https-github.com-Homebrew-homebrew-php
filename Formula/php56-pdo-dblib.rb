require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "c69a1d16fb9ac0b0f8edcbec30492c3c8b699b7ee727629abef6dbd6409a9bd6" => :el_capitan
    sha256 "949584bbaa4cc7a6a7746a00d28c7ec0a99c28cca7a53153b6187b97191eeb17" => :yosemite
    sha256 "8c84161998c7a79b6fa1d207d2f8f73cc308dbf85d098f5aa3fb102b5d352d2c" => :mavericks
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end

