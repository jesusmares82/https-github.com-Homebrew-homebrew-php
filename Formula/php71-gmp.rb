require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 10

  bottle do
    sha256 "74a5219302181631ca9689644c4f148423885a8ad296a243cb8df78c4998a5c9" => :sierra
    sha256 "401a3cc7069a333a1b760239e9bfef2aae37a13f8228e8561d1554ccf47a0060" => :el_capitan
    sha256 "e57a7fc7967e95fdb0b0fadb03aa3916a32896b0bc166e6002e0f2b9a9d33071" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

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
