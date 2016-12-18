require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 6

  bottle do
    sha256 "d626cbb8ebf20a789f1f30e783f589ec3b5251bf795765deb14ea239528cd2d5" => :sierra
    sha256 "1ebbbd3e747616f57065e0da2b44fb2fe4dc9062049e9adebc1497de92fae974" => :el_capitan
    sha256 "0a03284de0eed1a56bb79c86e76a4a512d5f3b493e7d047bd71dc5c748402015" => :yosemite
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
