require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 9
    sha256 "f879555b7d3bd7e6405346e19eb78b520adaee5a6f0f377577509d3fe75eb3b6" => :el_capitan
    sha256 "6c313f9bf0c274956b282b54146f6f24b58b5e2899033930f6dd4a9d6d2d2f97" => :yosemite
    sha256 "9e76ddd83a1074ae32e0120c0fd15f9598ec1473b79a97099f4805e5b7a6a20a" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

