require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "a6a87ab2b6d3441829a04f6677b090758a2e5963cb92ab7a9faf38f6ed9e27a8" => :yosemite
    sha256 "ddb2d70bf53b83911c16cd312b164682540d884009606ec87b4826f2fc867c3f" => :mavericks
    sha256 "dd059fb488e403c4e80c831cd4af66990d364c81e6b98401b974d3a5043a9ad4" => :mountain_lion
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
