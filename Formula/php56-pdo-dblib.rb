require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 5

  bottle do
    sha256 "72c6962d68ef902b5387585aca26e9ca2b0b3cfc3253db7212f807078c07dc8e" => :high_sierra
    sha256 "1efc9e97d54a9fd4d45db8c14dacedf56185779b93dc1fadcecb8f15759dad3d" => :sierra
    sha256 "3eaa91bedbdd8949464cf3b8342c3e2671de9b7fd7072a9a9ef0c7889321fdea" => :el_capitan
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
