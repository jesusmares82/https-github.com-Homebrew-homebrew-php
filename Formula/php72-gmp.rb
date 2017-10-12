require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 5

  bottle do
    sha256 "2d81bef39a9f27b2b8ea4acd2a0235ae8afa33fce0959d7ef74a86ec598d7ef1" => :high_sierra
    sha256 "0b9340247edcb45069a3869b39a69806071468db72581df33ad283d89298827f" => :sierra
    sha256 "3e2c0513672f3a56d145ebdb4d3058a8ac75fe50b8e299cfa9cd5d0116baa00f" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
