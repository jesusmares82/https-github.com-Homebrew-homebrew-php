require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 11
    sha256 "ebd4fae8db1409af31ee3d9e00fa7fe1011827d40b7bd2f46463c48aa1234252" => :el_capitan
    sha256 "af5fb94165a495def2efe5f128e901d2a2c0557e4fcd49c02a9ad0f2fcc6182c" => :yosemite
    sha256 "1d86d8aaf83039dd3bd2f79ffe6eae79ada1cd692e8588f092c07f8ca7cc12d0" => :mavericks
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








