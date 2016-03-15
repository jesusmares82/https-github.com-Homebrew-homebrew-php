require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "6754baf9e0964f934ae5322cbd05356a7769bc4ad6e305ab9091683bff99c42d" => :el_capitan
    sha256 "55a6b34ab0250ddd4de44b71df2b1a88a968ce160b21ab1ab7ee40544eb389e2" => :yosemite
    sha256 "f4dcf2d6d0067519ef6e8e130d73bbbf0c39f799a0dfd9bc5c5c5ffc30ce4599" => :mavericks
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



