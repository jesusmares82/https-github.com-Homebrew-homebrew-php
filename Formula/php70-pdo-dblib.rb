require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 15
    sha256 "d140542e86bc78bebdb8511d8201a2d8a4a2e22a781e5ca1f14be0d49734b9e8" => :el_capitan
    sha256 "351d491c412798b8d92037365f4e0d3cf0370fb617fc4d253743bce2b736415a" => :yosemite
    sha256 "0bcec9ae0b900e07cbb9e304a4cb88417d367d9262b9568a8bf6a001835fb154" => :mavericks
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

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end









