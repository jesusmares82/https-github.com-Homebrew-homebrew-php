require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 10

  bottle do
    sha256 "dc9e832afdda37c20d81c9fa68e5dd2ba50a6fd72fb9a6ae7f7507bcbcfeaad2" => :sierra
    sha256 "8930d6902e9280b62db3b783875eea248eca98235684e50747f6d8d1e68e98d2" => :el_capitan
    sha256 "7464dd726209b234a660c5ca4e56c7b0c9a520497d2de2c41d9e2d96e800e5b0" => :yosemite
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
