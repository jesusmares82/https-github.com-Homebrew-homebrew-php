require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  head "https://github.com/mkoppanen/imagick.git"
  revision 4

  bottle do
    sha256 "b7b373c9e3a89f56eeb70d5f9d0e5dfcd0d5800420aa44c9882788cd54ca71dc" => :el_capitan
    sha256 "e5b553c9e31a37200527caeaa81b6e710a10172f4181a5c9e9151ceb97425203" => :yosemite
    sha256 "9a4281da4eddf31351b5e9a71bdd702db8554263d1677d91eaf113854a551577" => :mavericks
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
