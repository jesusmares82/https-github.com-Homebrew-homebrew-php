require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 6
    sha256 "8a1fa24cc6768b3d6edcf6d645c9c20c4f3136fe451501d681ed144b81044791" => :el_capitan
    sha256 "a38dfc917892c1a5e039553591a1f713cb2022fc77dfc585ce3f63d2723d7598" => :yosemite
    sha256 "6021f27df5fd159695505595fbf86ff9689a5a625ece78536c66873eeaa5e08e" => :mavericks
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
