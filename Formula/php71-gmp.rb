require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 14

  bottle do
    sha256 "54c54a8a25dd7e3e28bbaeba7b104cebb1884ad55766c06eafdcee4728c04bea" => :sierra
    sha256 "1db613b14d288c1db8c1b58ec3e50f03def242d03f21b2828820c7772a7a8fe2" => :el_capitan
    sha256 "2d0e1aecf66f0bf78f44a79c8e75a28110f5f2418cae2f5bb8d0da839b5e3d66" => :yosemite
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
