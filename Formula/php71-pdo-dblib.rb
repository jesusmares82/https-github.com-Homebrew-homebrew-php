require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 10

  bottle do
    sha256 "a3fcf0fa15dbe6bf26936785ca9534291acf589e4e551a26a37bf668bb70f450" => :sierra
    sha256 "c65a296a76b3dc11b8b192213e6c04fe49e2ed092e03cee7df0bf55473fcd4e7" => :el_capitan
    sha256 "f39bff94e98175dcac1638747536d10637fbf4609ef63655ffd7756798c6a440" => :yosemite
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
