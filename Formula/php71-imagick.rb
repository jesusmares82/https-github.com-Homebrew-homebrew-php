require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC2.tgz"
  sha256 "beb00413702d479536a032be34294b6006fe0d8feab5c7d8af3dfa4fc6c370ab"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "ebd0e16ffb8adc2026692afccfe371ff492cb0b4358b9cdb22e240d5a44caeee" => :sierra
    sha256 "477d106e26d8a5a8623e91a98921bb777c3264be41c972b73ee013ed48ae62a5" => :el_capitan
    sha256 "93f51922b28c44bb734790e003f8d0ceca424b27de1d8413610ce1b4715500a7" => :yosemite
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
