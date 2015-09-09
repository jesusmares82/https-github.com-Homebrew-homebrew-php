require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "82a067a60ba8134bdca7df8481339056e3b1e55b937cf255e2c1ede6022756d3" => :yosemite
    sha256 "11dca5f56446624b8bbffc12a597a8fd45c873914de1916aa0dd10b58a99105a" => :mavericks
    sha256 "9caa7c0478928d13c1739d6d766e62f022209a0193af1ce0b2003ff2f4cd45bc" => :mountain_lion
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
