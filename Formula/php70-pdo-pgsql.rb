require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 7

  bottle do
    cellar :any
    sha256 "1f00f5433d4480e3cd9fae5fadaa6dc70572bf57515494463ecc4505f3bfa2fa" => :sierra
    sha256 "98ae75c518bc34fa1b0a90728eaf65698b06fa4319ea4a83267ec36ead57c98e" => :el_capitan
    sha256 "6f3afbca6bf235f7467720ce7ec42bb399ecfa2af6073a35cc89f6dbdf654c29" => :yosemite
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
