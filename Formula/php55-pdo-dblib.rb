require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoDblib < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "6990ba09c5c248096279e46efc47a6315ba63a3cce2bc29843d186eba58aad6b" => :yosemite
    sha256 "5ea59d4901054e378dce71bc467e820f9f4bcff95472e9f794adf9fe5f68f902" => :mavericks
    sha256 "5b164c53e3cf124bcb5d67ccddbe83179d9553083c61716884a7e2cbb66b6134" => :mountain_lion
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install

    touch "#{Formula['freetds'].opt_prefix}/include/tds.h"
    touch "#{Formula['freetds'].opt_prefix}/lib/libtds.a"
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula['freetds'].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
