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
    revision 9
    sha256 "27fdae82e21f8ebb8909467bbe175c8e3578c36db32c4912fa7a7f091e0b5484" => :el_capitan
    sha256 "ffc62a43ea7a637fcc49e39b6620ab13382809030d0b7e22fff9c59ee25a45da" => :yosemite
    sha256 "212bbb4ebf20957eacb8e57fbff1c07cbaeace37dfbc44fbd2c23d9d4bc83aec" => :mavericks
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







