require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 6

  bottle do
    sha256 "05dec2892177fc0083a659dbc29e81c8791226d050a3e7f4ea782ce6246f803f" => :sierra
    sha256 "cf96a1081a946587ff4ad64721d6516bff6ab213306032cbc45e75284df324a0" => :el_capitan
    sha256 "37c7079d1ab66d587c32390c8af3952b57f7b84d18a0201952e2f5e4ea13bc67" => :yosemite
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
