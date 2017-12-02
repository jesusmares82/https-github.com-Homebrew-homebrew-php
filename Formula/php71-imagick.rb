require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 5

  bottle do
    sha256 "1dad24d99b352603bdc82a7b47515e2a87c88535f198968cbe400444dc959d55" => :sierra
    sha256 "9699c15ba82861552f1a33f73a0bb5dd8e6d2ed10c36d330b9e07d47ffa05c71" => :el_capitan
    sha256 "e81bd3decac82b6bcb9087692764a477b5b17d3bc81c9f95fc4950efa7fb1f54" => :yosemite
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
