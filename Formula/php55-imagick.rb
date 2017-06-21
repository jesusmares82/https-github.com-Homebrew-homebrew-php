require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    rebuild 1
    sha256 "bb99934b7248e867798881a77bb82df7d0121e02ec4264d5799ef3ecee75c48e" => :sierra
    sha256 "eca044f0703b8968b48f7b9cae56037c992ed65473f34bde8e5ebf28456d39f1" => :el_capitan
    sha256 "c4b0dfc2da559e37d264606d640ce11c7d02dadba86147664482b40555b2f4f4" => :yosemite
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
