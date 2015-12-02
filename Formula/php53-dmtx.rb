require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 1
    sha256 "2d94b0e2c675b14f1d1497320dc8d88fe426d327f80008a6b4e58c19482d6efd" => :el_capitan
    sha256 "fa0f2e6764abbfd30c6a263d115c3bce58920f4e0861b5d31663b8d9cdbade56" => :yosemite
    sha256 "beef7eaa88d668dc865704193202fe8a8009dfb07b1f67acef8ef3291d33a0e3" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php53-imagick"
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
