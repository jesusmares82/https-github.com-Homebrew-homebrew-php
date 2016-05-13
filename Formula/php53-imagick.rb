require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 2

  bottle do
    sha256 "0a00a1277485342b62a9da0dc67414bad91263948a407222a51de5a47e3836e0" => :el_capitan
    sha256 "c8fd27c37944be4c153e553824fe46af0f98fc84bd2b9b760a80ff65f0a1f441" => :yosemite
    sha256 "46c9529e24766aa851b3e4df136a0c7b4c6d5c5e2f80fca3be7eb26ce2736b67" => :mavericks
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
