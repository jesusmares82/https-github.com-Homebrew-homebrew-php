require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Imagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "60dca304888c91f9f646402fb07670144c74738407e47ad58138ce74a8c9b339" => :high_sierra
    sha256 "d54857376c5ed7499ed4d8e921e25adaf8dde18a6dc8aea75e23e5cfa6b1d9d0" => :sierra
    sha256 "07632930af51ecc26790160afdb8d3b3987f766bf8076a3e4dcaf091f0de8fd6" => :el_capitan
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
