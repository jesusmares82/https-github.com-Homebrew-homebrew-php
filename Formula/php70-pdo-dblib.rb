require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 9
    sha256 "f80cac76663b3aa138cfd73d9392f9ffdcefa849d71bde65e34a1854c49550b9" => :el_capitan
    sha256 "d890977ddd5bae1cd3b42b182c2731e66468d1fb26ca90236c6bb58eb2163c1c" => :yosemite
    sha256 "fc574af905cdc6c32a6d3b24785198f8eb3bf234b709e71604aba8d6c9102a16" => :mavericks
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


