require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Magickwand < AbstractPhp56Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"

  bottle do
    sha256 "608349a9ea9036d5b46f9306924a7b927f2809299a1d018d82cb5e6ed9d2de2a" => :el_capitan
    sha256 "b0f366a401648c2dcb00c09f89a018ddaafb3297f252874124367a4ceee22e41" => :yosemite
    sha256 "4db70bbaccb7b25645c00da0106114e3341d61c330015d4b81c0760303b2d520" => :mavericks
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
