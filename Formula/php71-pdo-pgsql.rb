require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    sha256 "f2244817c5c48f329374abb4fb75f2ce18283de7f1e6611232d30edbb2a216b1" => :el_capitan
    sha256 "695957226452c34d5ffb0806305bebc3267b97108e77f1a40f4ec3dfb80e8585" => :yosemite
    sha256 "b71c02d3a5c403515be14858b0753d0171be288f2351b4a8e0446a091c3d4c4e" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
