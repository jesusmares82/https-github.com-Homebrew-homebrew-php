require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 1
    sha256 "1b2f05953a0eecb0f622bc268d4ea111cb6d659d6062b58a5828e1beccc6323f" => :el_capitan
    sha256 "cff6d0ead77e5b6f3089663f5b2bdb783a09ed404eb4af94a5e8cd8da9ccf9cc" => :yosemite
    sha256 "f56f8aab243fb6f01d614b0b680e57295a9b35122e3746c6aa6ebb4c35173dd0" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php56-imagick"
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
