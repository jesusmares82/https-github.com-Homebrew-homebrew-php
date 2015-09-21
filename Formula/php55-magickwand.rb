require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Magickwand < AbstractPhp55Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"

  bottle do
    sha256 "44446d79860c7ae10bbab175bc4fb6f7d30c26324dd905b7e51afba91bb3f5df" => :el_capitan
    sha256 "234b0802b660034f87c69746cccbb72d2c9d9a64121c4aa7096fd4b1f7e94446" => :yosemite
    sha256 "c2fc0cedc98e91b984d4b273c3833f1a99510ffb0839293c79e34a61e1d54e0b" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-magickwand=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/magickwand.so"
    write_config_file if build.with? "config-file"
  end
end
