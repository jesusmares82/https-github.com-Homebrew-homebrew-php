require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "81a0757bc34bd16453498b945f2e437749cb879d747f59befa54963572e8c13f" => :el_capitan
    sha256 "d6d91d6d9e9c2d3466c878a493e5fc98cfd51d59662b20b67a74112fcca41096" => :yosemite
    sha256 "b9ac2f48f5f47affb4027324cbe6246d7cdf814979d820a35e9981acc1fc6e62" => :mavericks
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





