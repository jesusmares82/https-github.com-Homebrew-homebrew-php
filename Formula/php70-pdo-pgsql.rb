require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 16
    sha256 "3d1cf485a5c08fa8c6a12298ab3fdf94ccef657ad831498b3f8b6597c615adf3" => :el_capitan
    sha256 "b3bb0d951820b647d128acba3c9418337ed941648598cbe670da408b9f1e582d" => :yosemite
    sha256 "c149bb99a86e8c360e5ce20f95d1f9d274c3fb83ba82df9c9342819eabedadbc" => :mavericks
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









