require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 14
    sha256 "51728eccdab99d305fd22baebe4553d29586ef18b20cc99ebcbd176a7c3a7960" => :el_capitan
    sha256 "43a8c95f0f0ed1f3a6720c284683b844e4f3b47e61c2047e31d8a22a01f5a5e1" => :yosemite
    sha256 "2d88e987a12380e42d4f69814435328f68a2adf8e89de9cd4d88db4854de33db" => :mavericks
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







