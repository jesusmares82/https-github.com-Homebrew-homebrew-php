require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Magickwand < AbstractPhp53Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"

  bottle do
    sha256 "ae5c8a0f104157ea40a1de9273a82fcebda2a471a183be24f690faacc2512cdd" => :el_capitan
    sha256 "e2c289ddfd96685f30668118cca8c347132e2fd518b04a95dc5cfd6c8d074650" => :yosemite
    sha256 "48672a2827013b4ce009448a2dfe48ca02156dc4752debc8fc840b7022994d75" => :mavericks
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
