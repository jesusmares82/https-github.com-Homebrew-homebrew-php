require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "b4da28f18dc6a3d888fdae1d92aaea67afe41e7bedf5050ddbb87d8163c7a688" => :el_capitan
    sha256 "493a8bde214416f5c12a8a6b86489d97a65ebc0ad4a63a5c9a452c777ad8f87d" => :yosemite
    sha256 "0e68e801b350e113391267eeabcd44b1675eda2ff3e0a5c7957411b1da813951" => :mavericks
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
