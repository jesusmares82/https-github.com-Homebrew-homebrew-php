require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://github.com/mkoppanen/imagick/archive/3.4.3.tar.gz"
  sha256 "15be7add24705e2541a07425a0806c1f32364399408f757964b5ddf0a0e9cc2d"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "97c1d05db7af6e7747a1751983b29f2a8e56382ee4e1fd54dbed39e9dad9c7ee" => :sierra
    sha256 "807b2e93df790ddd3363ccb237f4c81f49e9ad78e86dcded2c23a2188d8c92ee" => :el_capitan
    sha256 "8b23d96915bf908bce891a22fbedb1715205f715818a72c2d500dc7396b474f8" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
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
