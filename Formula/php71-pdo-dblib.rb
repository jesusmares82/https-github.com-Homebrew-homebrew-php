require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 17

  bottle do
    sha256 "f60eb87a151f28025d4516a0c194df0a1ef07cc70688699f57627f48463dcae6" => :high_sierra
    sha256 "348e26c7b125fe3c46891403632e2e5bb841b3f82d4e74d663f1454dcf9b4279" => :sierra
    sha256 "33895c2a6506871ac572956debf0c4d0bf692636f681665c6ca1da00c0315a0b" => :el_capitan
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
