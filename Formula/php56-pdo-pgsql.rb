require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 5
    sha256 "b012684a2371b7867d14ef1e8efd8df88fc0dfa8f9d46a27416566867941fdcf" => :el_capitan
    sha256 "890f8e5a7770978f4e39ebf56e57a613dc3599db3581b5ddf350538d99a899fb" => :yosemite
    sha256 "5dc9ac84804b22099143096c77dbd63d75c7794c183990a5186d5bb758a8cefe" => :mavericks
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

