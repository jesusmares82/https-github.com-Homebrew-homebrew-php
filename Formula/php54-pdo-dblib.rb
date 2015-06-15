require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoDblib < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f2ad0be1cb5d3c422d80a99b2535d36119ecdce434cfd0d4ebb208d06a0516cf" => :yosemite
    sha256 "34eb5697dc634fd74353a77e20e2c44380fe12489636a3db54eccbb2669b918a" => :mavericks
    sha256 "154bd1ab9790fb5c4eec9c30056feb26e64eb407a55ec7f94fc7dcbf28b9a230" => :mountain_lion
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
