require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "0a9a25cbb40add346fd70dfe4f0b6f29f072df384a62ead49c6904b962367d52" => :sierra
    sha256 "906a056a9a73ee43def3c023785553b2d91efc6c59ddf894bf77d5dd7afc1f47" => :el_capitan
    sha256 "ffff8b063a840ce8c1d89f86bf17f38e1f33ebc4dfd6519a2fcd9e04f6751677" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "imagemagick@6"
  depends_on "php53-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV.universal_binary if build.universal?
    ENV["PHP_IMAGICK"] = Formula["imagemagick@6"].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
