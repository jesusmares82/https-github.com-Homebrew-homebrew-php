require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "11fff8682211aedf099fc0b783e9cfebedfd5d67b4a08e3e72559c2bda8b6c21" => :sierra
    sha256 "c1be9b5596ba49c8a54f503c46c303ef39fd35b0b110eabb517bc7920d5690da" => :el_capitan
    sha256 "eef24c05c7884205d10d00ecc93c241a669e6f9fdf1325c49b634c5715180220" => :yosemite
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
