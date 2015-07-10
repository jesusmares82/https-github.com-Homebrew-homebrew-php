require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "7bc9b33f1e0d47c052c70ca55a06a6b09242e4dc3ddc8b8e14cb77f14cc99a27" => :yosemite
    sha256 "a535af9798b8861f3b1d3a3a23f742b24dddb0710883beb32600f4681fbbf7e2" => :mavericks
    sha256 "c795bae56ab095d8b30889bcc30243769ca412a52a5b5d13f3121e06ef66f054" => :mountain_lion
  end

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
