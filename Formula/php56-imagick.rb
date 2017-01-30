require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.2.tgz"
  sha256 "8e16b7bc6cf6567f4b4c4ac7294cbf650fe050a848c6a7ba6e2bee02097ab4a8"
  head "https://github.com/mkoppanen/imagick.git"
  revision 1

  bottle do
    sha256 "6801b5de8c9402b875f3ff2a500dc54345fabaef30d4a107f4962ec641918cc6" => :sierra
    sha256 "d1e4353760f1bd1fc1c7a662393d49be2bcd1bf3303a5d31e752fd82f461d329" => :el_capitan
    sha256 "62b56fdad063a084eb6843e8591e25666b9cb0d170d28d16fbd735e9b1c1505b" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

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
