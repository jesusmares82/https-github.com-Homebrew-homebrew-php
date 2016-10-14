require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 4

  bottle do
    sha256 "3200018fbb19f5707b27df6d72d486e0fb5a05d9ded36c3329e9b6ddd2c187ff" => :el_capitan
    sha256 "19b9c05b366e96a3aac5b39f64f4f9bcbc0249172d08dfdb881dfb0a43cb32ac" => :yosemite
    sha256 "897345fef5746e089d158909364cc01ff13e1655fde1d48b6efb015be00324ef" => :mavericks
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
