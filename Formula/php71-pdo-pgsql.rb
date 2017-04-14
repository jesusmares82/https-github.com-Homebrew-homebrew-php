require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 11

  bottle do
    cellar :any
    sha256 "e737691eb9446300c311c832a3d6f277a468676fa3787a0a97ecd7d5ee595f37" => :sierra
    sha256 "2c1fe43227ae83ed1c3616d6151563d119aeccf286dd829bae83305dfb305d58" => :el_capitan
    sha256 "2cb19aa4ce31a66cbf27dd98733b264beed34fb06ef6c9821009e764504c797d" => :yosemite
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
