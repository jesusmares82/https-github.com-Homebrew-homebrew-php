require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 4

  bottle do
    sha256 "0a7418517d06c30b3dccf90876c405dd8ce7814516bf3bd89fd0edcd1356b607" => :sierra
    sha256 "c111a0e70d455bbc9086ea5fc30c89d5c96f630be181487d58494c1038dcbe98" => :el_capitan
    sha256 "d47e4ca134f01f5a832552fb3d3a15681cc3b11cc0295555bba1af51b3f99d93" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
