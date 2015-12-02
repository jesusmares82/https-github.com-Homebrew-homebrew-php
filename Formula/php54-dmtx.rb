require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dmtx < AbstractPhp54Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 1
    sha256 "164b3a2779b38e4f9ec7a2053ec84e5b58d6a90d2d7abea606522c1dc902f515" => :el_capitan
    sha256 "54bbaa53569f14116c318edfbe44e89060a7f4cdab9e1ec7a5e8d848091664a8" => :yosemite
    sha256 "3342c34b96360f7005da92f5e54bc623b4f206872ee8e716b086b17403470d97" => :mavericks
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
