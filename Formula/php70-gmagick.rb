require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.2RC2.tgz"
  sha256 "7656bd9042c2aae1325b1cb49e55d9e8ec31b911decec33b6f176195ee1d515a"

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula["graphicsmagick"].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end
