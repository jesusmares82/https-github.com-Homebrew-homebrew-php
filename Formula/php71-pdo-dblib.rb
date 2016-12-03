require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 7

  bottle do
    sha256 "dfa1c88a38464dc79445a79de57c1b16a82a559399709163dc5e56e6fae0081c" => :sierra
    sha256 "2e9eca4445c89e5ddf70f388711da1d77d9d0ba065f8bf781f9149dcd1d8cdd0" => :el_capitan
    sha256 "eb91740c102f04d4b0061ba718b71bfa87e550a711102ac1fd399cafa565fdfb" => :yosemite
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
