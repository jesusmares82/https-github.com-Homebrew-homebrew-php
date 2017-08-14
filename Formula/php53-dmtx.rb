require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 4
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "3a10df1e0eddb07df632cf7259a80e5cc7f6fef05b4f8e94838cdb3cbb631728" => :sierra
    sha256 "0474d312007927a077f088b664186589e858cb95f6417647f8068ffa5232b08e" => :el_capitan
    sha256 "e200055c1324b42e95a8176dfba00a65455b18b9b694b000348fcff1b5972a47" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "imagemagick@6"
  depends_on "php53-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV["PHP_IMAGICK"] = Formula["imagemagick@6"].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
