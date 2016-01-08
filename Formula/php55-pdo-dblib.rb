require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoDblib < AbstractPhp55Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "3e8b3805f8a3eaa0603ebe6182c1ce2a468a234568bba48faa382be1a29ccd2a" => :el_capitan
    sha256 "c16032b57e727e3d779d6fd540dfcecba8508888b5de5edf7424a7cd0eee6da2" => :yosemite
    sha256 "c39e1ee5ceeb510e1e76c6cf0d6e3183842f81c0ee26370ef51fcdeb84107add" => :mavericks
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

