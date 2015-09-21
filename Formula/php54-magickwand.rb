require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Magickwand < AbstractPhp54Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"

  bottle do
    sha256 "ab207b394a1cc9359b5179de058412243a96f27c4f9d907d42e9050c50e46116" => :el_capitan
    sha256 "f5a39de8c10d7ef8e323503d2caa422a4c72250aae0919e4a239ad9ceb5661ad" => :yosemite
    sha256 "0a6695ba7eac55a90a50d0175309eaf5be996ad08c01e2e8210eafcdc85a97df" => :mavericks
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
