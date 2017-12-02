require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Imagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 2

  bottle do
    sha256 "07747282f3684d35b14c83ab91256fa372f89adce56f588a069ed9b6c74c4d12" => :sierra
    sha256 "28d708ee1fa1cbdefb344a559872c699622198f1fcfeb599b4ebe0cec89abc1e" => :el_capitan
    sha256 "fc5072c398668519a0fcf2eacf7f79600eb3c0616a02cdc37685820246b81005" => :yosemite
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
