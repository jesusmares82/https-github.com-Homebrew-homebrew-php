require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 8
    sha256 "fbbf2a3c71dc65a176a99144079344226de406a3723159da21415cd4bdfdc88f" => :el_capitan
    sha256 "b066b1ae2b44bf2c83aabe02158c861f2c811cbd53c02cb5119d74b7ed87672b" => :yosemite
    sha256 "11b89aeaf7a26854d86d6feca14a573c8bd214cee0885fb5ee1abf6a4a1a8be0" => :mavericks
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






