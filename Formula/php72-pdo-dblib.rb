require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoDblib < AbstractPhp72Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"

  bottle do
    sha256 "5af18368871897c47501f29005fc55cd635f4aa126b9194bb0b721d60c4424d5" => :sierra
    sha256 "6a33f996f2ea33cc0be89f6a6cf631c3f450ac413bbe0f2da850d78351fb61e5" => :el_capitan
    sha256 "9bd368aa26ea9cbf39043bb33b8ff61a0160c067e1456065ae5e588c5388e4d9" => :yosemite
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
