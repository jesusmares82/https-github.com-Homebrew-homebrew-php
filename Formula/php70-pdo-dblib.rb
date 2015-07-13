require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "dffabf63aeadcbcf2235f52b89746da28f6863fe3686f286c6539d5dd8d6a23c" => :yosemite
    sha256 "0baa0545978f4653f4a16f8203f11f1cb8aa6dde55995db840634968cdf58e90" => :mavericks
    sha256 "ca5152c1e7a9a2e6255510daeaf29c61f43e881f810f8f298d216307deda8401" => :mountain_lion
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

