require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    sha256 "de7432094ded3c474f5d385adbd36f037973de29fe075f1f2b479c9093359d87" => :el_capitan
    sha256 "e0651f8238e8872bb4a1533021e8cc3370e10c6f9c29748f3b9da4d4d87672a7" => :yosemite
    sha256 "c748aa9255ee3310b3a22ade735cdadcf9b3e6310ba60c9f2c77d4c29468b3f7" => :mavericks
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





