require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dmtx < AbstractPhp54Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"
  revision 1

  bottle do
    sha256 "6f78fd5c14baea6f20bf59d50639fccf89e8f39e2da04ce08a05b078158548ef" => :sierra
    sha256 "5ecb64b87917d018e3b21c796e569656ea5eec4d5065eb826add42180a73305c" => :el_capitan
    sha256 "b81d46f8c90a1c6b8d5454cc7ecc2aec9e2eb5f47fe8a96322ea7ef2906ce6b4" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php54-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
