require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 7

  bottle do
    sha256 "46625e528e4e34789520d0f0c249f1ca0fe807bbcf7b9e7a48e14f1eee6d3f53" => :sierra
    sha256 "f5d8114610b6b433f0d021e373d4788893c329f86319b6b71138f451fd86de35" => :el_capitan
    sha256 "5ad034be6de0edc189e87f037b06fd019b83011fa8fcc26a6415ced193133c4b" => :yosemite
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
