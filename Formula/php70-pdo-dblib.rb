require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    sha256 "448f7576f9b115e6015178ea2728af63f9934e9bad7ba3fbd9c8913fdbedd2e2" => :yosemite
    sha256 "dd3fefc3e6d0e335b5ffc4d0901577750f1fd3ff2118b0c9922d0d804007f7ef" => :mavericks
    sha256 "037d706c96f3df0349101aec34c82bb111711b7dcae97814718ea9bbf9dc1fd1" => :mountain_lion
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

