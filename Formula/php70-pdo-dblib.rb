require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 15

  bottle do
    sha256 "bfc2272996a4a1b502d9970875e77e66097c784496a39823a56885a46311b3f9" => :high_sierra
    sha256 "361ae7b6f12334a3d649883883f6c7a5397ca86249afa9438f60643842c8c3a4" => :sierra
    sha256 "92311a816e91b404af2a2fb9794fc277372b65f83217863b641ef3ffd33753fe" => :el_capitan
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
