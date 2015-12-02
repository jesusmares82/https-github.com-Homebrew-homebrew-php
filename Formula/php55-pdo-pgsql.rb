require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "f94a6866456c1d75e233e2d8a8096cd081a460cc47409061c3ed7ae23a580c15" => :el_capitan
    sha256 "3ff06193103d25cc93a8bcbd04bbf27ad945e914817531cbbdccec54ef0fc3c0" => :yosemite
    sha256 "6a214826a608d55cdb3bb7132eed6fe3a5979f75ff6ebf507ac69a77c7f33d42" => :mavericks
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
