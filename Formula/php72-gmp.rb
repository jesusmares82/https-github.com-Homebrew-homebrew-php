require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 9

  bottle do
    sha256 "a3cb850066b43451e8eb00ccbb9aef8f8c7a6482fbce49def949b3ef4c316d19" => :high_sierra
    sha256 "14d254fb7795564c08df27a2423e358d809764532061845090a3d90640641e95" => :sierra
    sha256 "0f96186a84636119615394312aac2bcafb0bb989a3f32b66efa90b97857618a4" => :el_capitan
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
