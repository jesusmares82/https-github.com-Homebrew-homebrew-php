require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoDblib < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "3dddcbddb095ed407205e6b2dc4c7dc55913f97fe98683e1edae1f3fe5fe0617" => :yosemite
    sha256 "c4d3784a94d9656d27b8a95120899d4a0730bec983c1befc2d97910bb44275b3" => :mavericks
    sha256 "36f3a7fc8f7718f994f6752a3634c095a702d4bb20e7f2ec7e6a0c1dd6fe68b6" => :mountain_lion
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

