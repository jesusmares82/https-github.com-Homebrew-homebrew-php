require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 1

  bottle do
    sha256 "adcfee73b7fd8f1db50f76eed31337fa9ba1b281a7a349649041e22175118311" => :sierra
    sha256 "92ccb96914e17fc1ecf9121f6bcc2d75ccf16ae1b9f4f900328dc267680fd4ec" => :el_capitan
    sha256 "aabfcbd74ecc7afb5230ced59045c65b10b641889d5c47f4957b168ce1887ab7" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
