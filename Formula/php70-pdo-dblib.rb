require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 5

  bottle do
    sha256 "60e75e74f2fee6c7203f5470cc6a648a97362495e0b065e6202ee3022fcb8489" => :sierra
    sha256 "01ac290756227250f30c4b032ebc9404717120236ae110d01052e1d3ab0a4d7b" => :el_capitan
    sha256 "2c9355a424b25ae8d3464960e0cd30d9db37b8937410880551a4043aa819be21" => :yosemite
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

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
