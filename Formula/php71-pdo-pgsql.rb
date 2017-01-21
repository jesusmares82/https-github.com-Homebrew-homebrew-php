require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 8

  bottle do
    cellar :any
    sha256 "1738fed153596d8e2b4cb97152c6f911c71ab60bf1a21c72976bf60982407f1c" => :sierra
    sha256 "5830955acfbeb572935109a458b470ccb14acb842adf0a14cab5bef83b35eb02" => :el_capitan
    sha256 "d5f877a28f84d9ba39a031651e9079b8face45e6c66b0f65527213bfabc88da0" => :yosemite
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
