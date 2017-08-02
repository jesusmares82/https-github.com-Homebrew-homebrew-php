require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 3

  bottle do
    sha256 "2e13891520d8b57bac0f104daf96531c8494e2f490e067a22224542367e4772c" => :sierra
    sha256 "44851d0535dac99dc02136aaab07e4af5aeb2268a2a53ff924836589ea382e3f" => :el_capitan
    sha256 "92970bb76685c14712df18da5b90ee14aa537cf9bb0e659a6846029da443e3fc" => :yosemite
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
