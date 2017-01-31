require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dmtx < AbstractPhp54Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "f0340d31b1cfa28419b05c30ce749bd34df157a6f372a639973fba9e44ab3fac" => :sierra
    sha256 "4c63bb38cc9f325d52d5c9e7c79d5303cc0b163055a6baf1db2aaadfc36b49d3" => :el_capitan
    sha256 "ab20cc7550576d17080977e5f97efd1be17ec6bc6c1c37b434d2e06f77e78aa7" => :yosemite
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
