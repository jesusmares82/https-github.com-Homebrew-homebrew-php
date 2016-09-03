require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    sha256 "6cfb2b680318c5e17aff79c2933f2c9ddda87f6edbb81979074a433f7c97803b" => :el_capitan
    sha256 "f1a54a082d2587719ba5baa4a1d397a60ae17ced4e9c003da0554b7ccd455294" => :yosemite
    sha256 "39d00565e4c14247744e0359690bdf38c54665d5cda852f474d8e1a78015be36" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
