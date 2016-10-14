require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  head "https://github.com/mkoppanen/imagick.git"
  revision 4

  bottle do
    sha256 "05e96f89e2d6953d2fa9ae9615ee4c0866ac96997db139f8d9d080872bdad47d" => :el_capitan
    sha256 "1588f4a7b40a9f1fbbf62a4b6bede9d3d8c3d3ed23b858b1f2f0f919351f1b83" => :yosemite
    sha256 "d91ca02ff78379855d9c3357800bc1f8811d26fb479b32a85fb4fcf541ac416b" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
