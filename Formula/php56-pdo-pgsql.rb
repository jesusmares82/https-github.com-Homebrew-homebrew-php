require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    cellar :any
    sha256 "6a872d62fcab9bdc86d53129f7a6e4966b7e3c3a823a9ef716361612e39da82c" => :sierra
    sha256 "dc6c1f7309bb3a10504a7eff3d284f440b6b3beb274f06346cd06ab12bba53a5" => :el_capitan
    sha256 "800cb01b670ce29e1eda2648a9fdb9f712ffabcf285d3dce066571087dc18f31" => :yosemite
  end

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
