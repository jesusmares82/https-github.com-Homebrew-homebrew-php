require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 8
    sha256 "5ddd9cfd947b00847d658cfe3879e126b3691c6af3177a746017eead81dda8f9" => :el_capitan
    sha256 "04b471a65be7db10394780654eeed6d6a4b1434a5caa1fad6628011aa3d2c1bf" => :yosemite
    sha256 "0c0dcd52d7b6a43160cec43b8dd4d9f17d598441d7c1ac5a06a8f7267af919f1" => :mavericks
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

