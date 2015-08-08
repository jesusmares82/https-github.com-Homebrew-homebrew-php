require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoPgsql < AbstractPhp54Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "b31d0706d6846c2163aa5fc655da17778975ebce47dc029d02a1b14b9b0a992d" => :yosemite
    sha256 "a8f43bdbbcacc0d7374795dca8f550f299631776e3957b1609811aba6de18e42" => :mavericks
    sha256 "ab69a1b204a4e4cd756ffd4b0f4d60e46eb2a35563ab2d0b66b52b6b0d6d44b1" => :mountain_lion
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

