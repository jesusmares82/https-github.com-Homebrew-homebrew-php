require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    sha256 "f940196a01008100536f86eda5e0a5f7b7e67c624f2a859e8c41e1d98a958578" => :yosemite
    sha256 "a51a5e9883376c265c26e0000980c5690678dbb854659a67d59cdea91cbc0f5d" => :mavericks
    sha256 "620b0e363907043adf39b7638a979f45eeb5513cafa0d18f936d8d6a83e15bf4" => :mountain_lion
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    touch "#{Formula["freetds"].opt_prefix}/include/tds.h"
    touch "#{Formula["freetds"].opt_prefix}/lib/libtds.a"
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("pdo_dblib")
  end
end

