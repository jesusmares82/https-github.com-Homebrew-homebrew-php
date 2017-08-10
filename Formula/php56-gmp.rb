require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "d5ae26608b02861f947b5d479accfd0f07f39ef71abc3c95739a1493960212c0" => :sierra
    sha256 "7a618a4c3401e6855f32d0550ca060c6b8adc23b57b898c46493c95961e23355" => :el_capitan
    sha256 "2578c734754b411ad384055b474bc4119a4c4e08fdae1f9e8327af6c3d2ab59a" => :yosemite
  end

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
