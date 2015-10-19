require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 4
    sha256 "b45b4c5af985dafae798f620dac7ef9ef01ab28b43a99952ffd6b364a637473e" => :el_capitan
    sha256 "c1de02be244e905d05a2b4156bff35bdf108d24ea0d10335d7870227d0790316" => :yosemite
    sha256 "6b3a3158124eef70dac4d2a3fea73c2b7495ba065ef0d4d0c831b489fafc5eb3" => :mavericks
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
