require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 14

  bottle do
    sha256 "a12d5c652955b2ec9ee94c0f4ea780103eb5c0c099799909ac4ecfb44a131b0f" => :sierra
    sha256 "3738d7f2f9ac1a8b742ff6ce961a6b62c5428058161fae7a5dbf0b544c7d24b8" => :el_capitan
    sha256 "c42ccf6c12a189f382de1eab9b6c515cd42e35fd78422ed908a1c42032a345b0" => :yosemite
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
