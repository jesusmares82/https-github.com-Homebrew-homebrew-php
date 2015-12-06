require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.0RC2.tgz"
  sha256 "5c9391d673f97b11c42bc8b05c4a096d659f1d7d38890d43fe7447fcf5f629d2"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "7943bfe40d4e09416873e22771e85ac1f7b3a5f3630aa03f8be4aec657a5e59c" => :el_capitan
    sha256 "87d32c1c0c08100e2a71e59aab55d3891fb0bcda9655f065a1cd3b205928a945" => :yosemite
    sha256 "f866bf5e05357783a7981ea9f0c73a096ad5d9080b10b6ce0f745d769baa07f0" => :mavericks
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
