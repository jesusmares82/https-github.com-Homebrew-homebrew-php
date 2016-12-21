require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC1.tgz"
  sha256 "50bbc46e78cd6e1ea5d7660be1722258e60b1729483ca14b02da7cf9f5ed3e6a"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "7b068248c53fd2b0ea423df983cd7c262b463dd9c35453ace29ee036a9e287bc" => :sierra
    sha256 "5f3669b03425a3c8249176392c98f0abd402c77353263e75f2f82f153172e376" => :el_capitan
    sha256 "a890e86c1265c7faab16d1e4d5792c78f6be0dc0bea9b37c06dee4d0cb60908f" => :yosemite
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
