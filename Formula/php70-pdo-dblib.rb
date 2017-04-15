require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 9

  bottle do
    sha256 "d1a02f0a875ebe8e43bd55cdecf87546beb928d366ba25d3db41677fea9adc58" => :sierra
    sha256 "81ee433d7d92ccca0ea11840578bffcad0650668c076607dd670f94ce654538a" => :el_capitan
    sha256 "13cf2e1aa81b44e5de05d2f552759d70342ff22e1fc4215976ac896e3d43d29f" => :yosemite
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
