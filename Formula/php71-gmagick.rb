require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.4RC1.tgz"
  sha256 "4ead19640bebebfa68be41dc0097a93a7bf9beb56ea82b27343dba8ea4c5ecfa"

  bottle do
  end

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
