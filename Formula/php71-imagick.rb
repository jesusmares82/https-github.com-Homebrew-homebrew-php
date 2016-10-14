require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC1.tgz"
  sha256 "50bbc46e78cd6e1ea5d7660be1722258e60b1729483ca14b02da7cf9f5ed3e6a"
  head "https://github.com/mkoppanen/imagick.git"
  revision 1

  bottle do
    sha256 "10c8da64436fa41d9931c30a234f2dbcc3c4748069a87e599e0b5eb18e204c0e" => :sierra
    sha256 "e9eb2a296e259b5de5c1f078963662a009ea0a799acf465fb1fcf63d36e25df0" => :el_capitan
    sha256 "de81d58f978025b7263220f38cc36dd6a5e2ff10431fe948b7815c7a56870e54" => :yosemite
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
