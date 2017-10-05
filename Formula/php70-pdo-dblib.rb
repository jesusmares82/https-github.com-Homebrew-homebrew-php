require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 15

  bottle do
    sha256 "2fb6d19aebb83abb6891fdb883e7ce32145c2c81f88a35d95181b5a6e75dd6cf" => :high_sierra
    sha256 "11b4ef69bbf26feca6ff4ac33c7d1fd161e68443b84e841b0e19ffb06253e1d6" => :sierra
    sha256 "6ad7ffebcca8bef11d2c0b8a2f0f8d2ea016b4654741b193278e59fb5a1967b5" => :el_capitan
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
