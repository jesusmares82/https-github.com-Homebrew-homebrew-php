require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 13

  bottle do
    cellar :any
    sha256 "ffadddfd27d65afffcb52e11fef8fd557e2738a840d15b90065d0b00f138fa8e" => :sierra
    sha256 "d792cfb07b49d96fe25da4072861e46f455f8ed624e3a5a0fb1ca583021961c4" => :el_capitan
    sha256 "3afa5e6d7ceac181c7061a699d3675081e99fc3f988b7e523e5bdc4c4eafce0e" => :yosemite
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
