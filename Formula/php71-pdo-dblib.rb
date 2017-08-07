require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 15

  bottle do
    sha256 "ca85aff450284b95119e29cf88a208742f7185f6e514c82553c238b4c172ce22" => :sierra
    sha256 "eade925ee3abac3e31a07e95690e07363bccfb44d3a9a00abb24a203672a014e" => :el_capitan
    sha256 "54ec0266f31a88abf7e3465c263bcffceb98c582a4ca144e7bda6299206a58c5" => :yosemite
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
