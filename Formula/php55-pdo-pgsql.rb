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
    revision 7
    sha256 "7adf0674b7887c6a845c556e46631300cc87e9b79fa56a841f702d6c85cc82c9" => :el_capitan
    sha256 "a7535e7b1060277fa72e013fc8eb0afea7c8a90fea7e11d207a2b3fc2ec6d470" => :yosemite
    sha256 "419492d2de4f66a19bfbe1d653792cb2c83f97c725012f2198c812a56cdb2581" => :mavericks
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





