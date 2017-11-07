require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 7

  bottle do
    sha256 "34c3f40bf994e34a92902d71fa48568a5815d5674c7ccf677bbad04b987d2d39" => :high_sierra
    sha256 "bd84713ba5fa168fb76c6996bc7786ccae38e2b7e5c4d0df71c452a800751805" => :sierra
    sha256 "f8a5084739c23898f32dc99bc38b6bc8b12e9fe21a592284801be7e03b3669d4" => :el_capitan
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
