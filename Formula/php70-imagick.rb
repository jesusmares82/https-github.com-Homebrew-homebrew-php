require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "3e1ff5482ca8fb41122441c8d7b5d8279d429dc7557d2ce63d2fec70cdc2152b" => :sierra
    sha256 "dee4a50a01c864a4fef5db3acd1995ff23e45f9e25f4d9ac46d11e6f5385faf9" => :el_capitan
    sha256 "fdfacaf444f10b46d074c5757f78ebf1636ee70fd5c1151aeb9b6e8193d6cc26" => :yosemite
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
