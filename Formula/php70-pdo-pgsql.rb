require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    revision 5
    sha256 "bc776f0d4397588891b0b388a5821f3bb8783ef81ceb3588bb7818d0230fae0b" => :el_capitan
    sha256 "e38b690ae8021b984952513c7410208b8e0bad58b47b200072c26f9a3b0db510" => :yosemite
    sha256 "65d6b48a16f2a2e354fdcf162ea8686d6301741977d07796c12fc4c478f523f5" => :mavericks
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
