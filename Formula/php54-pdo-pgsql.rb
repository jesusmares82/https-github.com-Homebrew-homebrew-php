require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoPgsql < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "076dc2c65832f23e8c1a8975624adfa13acd02f0147a64a821a67990b168a458" => :yosemite
    sha256 "0f416d0f41a1e3833e42974343300c3eb0ab0a5e77003a57d70130c2b562ffb7" => :mavericks
    sha256 "28d20d56fa41dda0d5cc7a8074c77636a147e9a5e51b1fc3372a7f29616c1f86" => :mountain_lion
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
