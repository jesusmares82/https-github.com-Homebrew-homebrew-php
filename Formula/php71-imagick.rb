require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC1.tgz"
  sha256 "50bbc46e78cd6e1ea5d7660be1722258e60b1729483ca14b02da7cf9f5ed3e6a"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
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
