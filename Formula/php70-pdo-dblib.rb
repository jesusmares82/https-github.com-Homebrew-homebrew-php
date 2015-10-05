require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 3
    sha256 "e896d0ed92e1d265d064f80110b8c70535513deb4725056d404071c5a13ab292" => :el_capitan
    sha256 "c77637d411d8ff52077adfea81262206a9e1b9b12148ac4c2e6f9e606b0cfced" => :yosemite
    sha256 "e13ec426f28b2429009f807bfeb8f511dd29b16a83f2fbf20b3b2ab3bd9f6370" => :mavericks
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
