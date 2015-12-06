require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"

  bottle do
    sha256 "988b7496f03169a83f09b109b1ba21c93d8c2928f474f456bef50d09a69925dd" => :el_capitan
    sha256 "70f3dcfe001fefce028c9398f8b387cf2f61d39a6aa0f4baf38bd3e53e98113e" => :yosemite
    sha256 "02f23b3893a495cf9aa131d121e0efe783f268f8c94a15454201fa57b0792897" => :mavericks
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
