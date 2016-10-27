require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    sha256 "8343ff74a6ff38aae6c06eb47714d8b4ade276d0ce6aa49201746abd3a2fc35d" => :sierra
    sha256 "e1277fc3c23f8a36980483d53dab81b91bdb97e113382dd3609a460becdb27b8" => :el_capitan
    sha256 "b2c9f76b06ff754d49fccad630a42db93335352d814034b689691d76ad32a507" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

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
