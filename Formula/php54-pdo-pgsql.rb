require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoPgsql < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "439ccc5aacba1886e3c5df0c86f3b29193724c8067e12732cd5fa8513594a24e" => :yosemite
    sha256 "51ada0afbda4e2e147c3b260611bf80fa1a2ddfcbedf02b8927eb3ed9ab03e5c" => :mavericks
    sha256 "20a7ec865c03fdd71f2f12f3422ea55d9bf30f42cefa06fc6b913aa81fa2d335" => :mountain_lion
  end

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula['postgresql'].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
