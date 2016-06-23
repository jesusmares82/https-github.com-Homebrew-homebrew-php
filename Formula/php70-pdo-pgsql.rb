require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 15
    sha256 "222eba75f0c8740bf9d4d89b01a56485cae59520e3cf33aaeb53957c4159d45f" => :el_capitan
    sha256 "dad5bbf1a58df722497ce56babbc473373cd16ae26d75509b3aac2a456dbfe2a" => :yosemite
    sha256 "c4e7c82d70a722a70d97d3c1531e3e14f15fe70bee3ae2cba997e1a34ef28189" => :mavericks
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








