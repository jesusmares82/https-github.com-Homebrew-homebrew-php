require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.1.tgz"
  sha256 "a729fbd69e0aa145824d61dc9225bfb636dcd8421874a5667ac3822e609449e1"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "df85dd2754d5bd6b7d43efc332ec0a8c1d0cdd1893753ff00fcf39b5881e5be4" => :el_capitan
    sha256 "c758aaa4ffc1b82fe4eafdff08cee973bba869b40545de38494db2edc01511b4" => :yosemite
    sha256 "8f8fedb0f8397dcde66659821f533e7043ef509405c997f3e8a2185a1ba42f02" => :mavericks
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
