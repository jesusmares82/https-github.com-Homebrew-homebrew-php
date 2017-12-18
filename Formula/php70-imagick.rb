require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 6

  bottle do
    sha256 "7e8ed5a3ad186b7945c60b70c7deddbed2b4a3f7a405114ceb61f7ed56f116ca" => :high_sierra
    sha256 "dc24350925ae7cdac7d4ee9c53c117f6d656095069eda33ed27ee1c44dbaecff" => :sierra
    sha256 "3330f25d32c5786dbbd72d520637119e76660a3611b239d2f2f1e7bce18bfca2" => :el_capitan
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
