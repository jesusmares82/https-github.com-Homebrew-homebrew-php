require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "975e302a686476e7b4d3539a0c405a958525683c918f3f5d2b73b933453ba98e" => :el_capitan
    sha256 "5ebe8399685c25beaf418664be1c45975e089ec6b447d7f26c4bafd1632c7bd9" => :yosemite
    sha256 "767cb7e52d6e109a11ace10b2b957b634fa49155083fb2f0ff4eab43d6dfb9de" => :mavericks
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


