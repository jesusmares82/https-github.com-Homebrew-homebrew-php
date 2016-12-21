require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 6

  bottle do
    sha256 "fe30a14a3c8d3582a8f192d3abb6af71abe434cad63dc7405926c61b88b2368a" => :sierra
    sha256 "c626c396414930b0a41fa51452d38b5e2d2a7ff320ef7d8a40bfa4afa498aee1" => :el_capitan
    sha256 "fb7d9ef0292faa59d6b8f7c545c2676aa030c1993467ee89ebc80cd61515d24a" => :yosemite
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
