require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 5

  bottle do
    sha256 "d55e1e0933b52094c26b8c8935190703c6c1c126d3adaedc1c4c1d5e148676d3" => :sierra
    sha256 "eb0ec48674d774422cc3c38a6f6f86da50d9544c3761dad4db8ce383178876c9" => :el_capitan
    sha256 "1635fe4e84560d004da10d58fcd1f0a9e63776a5e210ba5f5c5d0cbed981309a" => :yosemite
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
