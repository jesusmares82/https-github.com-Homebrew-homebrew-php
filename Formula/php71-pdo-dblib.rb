require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 13

  bottle do
    sha256 "d8b93f1a33679ecf8c2b24d9fe33223ea78be6738e95292e6ba62244fb64a19d" => :sierra
    sha256 "86d4d92c1a60e2ab50eb9de4937d7960db3e2012c44430180110dbd1c2b5745e" => :el_capitan
    sha256 "bf858d740206587ea9923a23091e8baf67b3523680b31a791607765e8103370b" => :yosemite
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
