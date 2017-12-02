require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Magickwand < AbstractPhp55Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"
  revision 2

  bottle do
    sha256 "d7672826c39495ffa3f8ce89079f8cf16afe59961e6172b8d2e23cd1aebe968b" => :sierra
    sha256 "17c6e5d55f192c4e85bc78a78e4459f0619d1f4921bcd99bc8fa9f3998181d65" => :el_capitan
    sha256 "8f3f54da672465fdf4ef0bfa5b1235a19122c31e36f67ca8c66a8a75f7db4d77" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick@6"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-magickwand=#{Formula["imagemagick@6"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/magickwand.so"
    write_config_file if build.with? "config-file"
  end
end
