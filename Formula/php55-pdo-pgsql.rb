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
    sha256 "34b4b7512454af6b28ab2e290f6e0714a7a1671733409906b6f2697dad6cc973" => :el_capitan
    sha256 "fff04a31665e7a419a967f0050bc4f323d229592b784cdf38d6be80e789f4fb4" => :yosemite
    sha256 "2a99411ffc61285036fe1f87b343cbe8c2aa0b6b8ed2ebfa727ae9c644670116" => :mavericks
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




