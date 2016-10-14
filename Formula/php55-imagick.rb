require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  head "https://github.com/mkoppanen/imagick.git"
  revision 4

  bottle do
    sha256 "b2a6349bc7c2768158faa09ce301bdb2c92b4a06e5a6f755dd8d38246a61ffbc" => :el_capitan
    sha256 "b944904d98defa81aa9adc44590d367fb4266576dac593eda8c6f239d100d13f" => :yosemite
    sha256 "b2f000403c388a14e377e2769ab892f1f471c5d664fc35fc36ab895006fe6246" => :mavericks
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
