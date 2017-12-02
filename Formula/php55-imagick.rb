require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 5

  bottle do
    sha256 "4f5f8650e61c319d524b99cc98ec40ade02856348451df4dc0c08a8ad98bf200" => :sierra
    sha256 "c92a90bf519fbebf3fbc7a050e73dbded0fac399c32899d0c7eb03b7a6f94fb1" => :el_capitan
    sha256 "a61ac1e089f3625451399cee3c8c91846b84fff7d4b91ce42c2d52f499d07568" => :yosemite
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
