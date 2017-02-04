require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://github.com/mkoppanen/imagick/archive/3.4.3.tar.gz"
  sha256 "15be7add24705e2541a07425a0806c1f32364399408f757964b5ddf0a0e9cc2d"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "796064558066b6cd4ef99a4ca9be572dfd321e78e7949c02f7cfbe4cca4c6aaf" => :sierra
    sha256 "fb45332c88f54559d7ff05da19f1a62f6dc0cdefd502989ad148422ed2b5632a" => :yosemite
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
