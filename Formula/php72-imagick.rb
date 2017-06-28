require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Imagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "bcb9c7dfe2c80db04bdf95c4b4e4f4d8f22d1fc97be7ed9fbbfbc64250e71ae0" => :sierra
    sha256 "7f010b06855883127c75c73abfa7d47a11c55081754c355eb6e080f13d2414e3" => :el_capitan
    sha256 "fe0a8dc9b3f87caffa831ad4d68d84d9df647a1b2a88b4d5d445d3ecc8ac8fa6" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
