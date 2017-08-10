require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "ddf5950b011c9e6a0a7a6a7896e3e57e8667067c1f4e3c5aac0312e8a3714a35" => :sierra
    sha256 "1a5a32dfb4a10e37e59ccf72a668527120eb242c31e486267fbe96960c5ff91e" => :el_capitan
    sha256 "a501aada4cfd82425cf45a89b98b2bb87d3661c512fd5b91a5ca5efaebfc931c" => :yosemite
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
