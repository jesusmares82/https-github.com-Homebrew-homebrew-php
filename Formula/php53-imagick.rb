require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 4

  bottle do
    sha256 "a3f8953b27d0b70ff78856a8ca65dd8e838bf3838e86a176f55a84e98715bdd1" => :sierra
    sha256 "062cf7fbb604d3199295f95c929062772229b433f0c6a49d8504104a6eaa32e9" => :el_capitan
    sha256 "6e1056cb443e128a093429932fba1f663db65f0e5058f648fe14bbb70e59c417" => :yosemite
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
