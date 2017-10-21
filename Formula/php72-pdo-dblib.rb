require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 6

  bottle do
    sha256 "8d1c07748490ed1172bd2564f5d7862cd84cd2767eb0db7821c2c06d85a980d0" => :high_sierra
    sha256 "d3e149f1124f7fbd8b01bca2bfe98ee8dd0a913efe8212ea6e0084accbe8b8eb" => :sierra
    sha256 "420dc04036ef71b8a58c075a69a7e8dbd3df505421c9670a18face5418393946" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
