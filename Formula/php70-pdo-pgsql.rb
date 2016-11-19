require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 5

  bottle do
    cellar :any
    sha256 "2a6be9c887c816ff1a49477426627a35301e4126a3446d1c3ce618a5a3189616" => :sierra
    sha256 "aa638290d4fb011b4920901410fb0d9a770cf5b911191bc5d38b358d5e8b63f6" => :el_capitan
    sha256 "9b527bd1afefea98ec699a332fd57ed622e1013a0619b7c53e2f3cb77445d422" => :yosemite
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
