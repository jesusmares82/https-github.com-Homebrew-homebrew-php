require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"
  revision 2

  bottle do
    sha256 "ece38a1dbd604e259a8bb03bb7c1dda022c55ce37b6179910761bfcb0bcf8003" => :sierra
    sha256 "476ddb94b153a3e28b52c58e4e621a14bf56abe87f2b8f80f7832ef78e9a965b" => :el_capitan
    sha256 "af647be3053d79d123e123bd62128e7ef88523662ebcc73646f606d87026a426" => :yosemite
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
