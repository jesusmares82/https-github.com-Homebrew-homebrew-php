require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoDblib < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "214ef3a58a38a312d08b726ada3b922803b483fd3f6f58f8071461cba0803d86" => :yosemite
    sha256 "b3d0f669a82264b69acf57f21de322a6c1a94123277aef5fd57f2ab4c4db3e2b" => :mavericks
    sha256 "77c3e8f6e9cbcd3cb0774d2af6bf2e4868aa9e4a9be4c88fcf63eac9ebf8623a" => :mountain_lion
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

