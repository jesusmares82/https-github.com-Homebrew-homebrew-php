require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.2.tgz"
  sha256 "8e16b7bc6cf6567f4b4c4ac7294cbf650fe050a848c6a7ba6e2bee02097ab4a8"
  head "https://github.com/mkoppanen/imagick.git"
  revision 1

  bottle do
    sha256 "3d008aa80208ea14181a03cca9e75aeca64e3ee2840ee58de678480190f2d586" => :sierra
    sha256 "fe271593f35bc84a8b38edf8363f057bc1e761302c394d659b62f7af4fe07ae9" => :el_capitan
    sha256 "05d23fd090bcf1d9cfdc0fb9d5d8749819ce68d274bad82bffe57e7d28d4f7a1" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
