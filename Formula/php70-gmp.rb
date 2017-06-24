require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 11

  bottle do
    sha256 "d0dafbf4dffb25512b5f801af408a849d02a9a0d4e0bb39aaf1041c03b3a2ed4" => :sierra
    sha256 "c0b377a418f7d14d0e5ffe5c889713e68d4f3a1055cae6d86264afc08a00fce9" => :el_capitan
    sha256 "6a98d9082610de57e643f75b1fc698f330de89551ca66dce68eeee2fea98024c" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
