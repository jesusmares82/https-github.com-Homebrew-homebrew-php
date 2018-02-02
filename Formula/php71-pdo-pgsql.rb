require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 20

  bottle do
    cellar :any
    sha256 "04c5c3537155b88d01fde5565eb5374a2c0d5c485fc8188c64033fb2c416594f" => :high_sierra
    sha256 "a16560802dbb705cfd550233240e54167ffeb0917d5d2344915e624c827d6356" => :sierra
    sha256 "e3fb51a90b64bf78f26b3524cd5cdceb5af910b1dbad6b33acdb33c22baff0ba" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
