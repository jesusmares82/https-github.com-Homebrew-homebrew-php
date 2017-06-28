require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.4RC1.tgz"
  sha256 "4ead19640bebebfa68be41dc0097a93a7bf9beb56ea82b27343dba8ea4c5ecfa"

  bottle do
    sha256 "68ca83d9c1cf2db81416445ad509c887ba8ba89429f37e1d9969757b2b52b086" => :sierra
    sha256 "77250e9b96c360e937847c15d3770b18565aad4f61665da7fdcc501d3a5982e5" => :el_capitan
    sha256 "c25954d583f24a7e977de4c096e16692d4abc95a31a06a58521eb4e7e5b81d5b" => :yosemite
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

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
