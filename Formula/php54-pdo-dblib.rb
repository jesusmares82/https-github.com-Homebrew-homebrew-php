require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoDblib < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f59cce6e8d3fc1e4363d79df0cb5dbb25913a85ace9343f616907515fc97bd30" => :yosemite
    sha256 "d63cc6f5f4897698a029f51b45dd2e40887dcbdd15ae6bdd9d8382158a25ca82" => :mavericks
    sha256 "ac503bf81c6fd61541a3df28b7494a98f2161869c1a588855c5688aa338af251" => :mountain_lion
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
