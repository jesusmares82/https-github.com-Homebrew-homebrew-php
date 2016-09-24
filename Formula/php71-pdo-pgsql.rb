require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    sha256 "054522700d1e48806dc7717284843a8f32c8fa61d69c93db1596ba7a7cb0c1c5" => :el_capitan
    sha256 "42421521933cbb1be15f3633256785d505671946606f0341879b5c5a305c90b3" => :yosemite
    sha256 "c040fc8852087b4e279022d820ba2ef2241fbd2d53f7a1aea5326058a281ba53" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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
