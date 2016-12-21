require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"
  revision 1

  bottle do
    sha256 "363c7ae1d60ea3e2905e087b7ef8a9e5d6a1490b9d2c46addffe1f96db835400" => :sierra
    sha256 "24887d4492346f27afd5ba4d7f481e7a786d4ae76801f371276581b60ed43dc3" => :el_capitan
    sha256 "5473cf474891fd1766fabaa12c07e19dfd62c9fcfddf3cf7eff16c3a194277e4" => :yosemite
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
