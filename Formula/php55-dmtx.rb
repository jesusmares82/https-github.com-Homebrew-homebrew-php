require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "3e60c832f3bde611744826f5ae0c08b84b574b478778eefee5a37615fb3b224a" => :sierra
    sha256 "28fc88adb1a47a5ba536e0f943573833eb3ecbe74b70038c98ddc462411518f6" => :el_capitan
    sha256 "99255d25235b27bf43349e18d89e77410fbcae89cdb23bb56f8805b8114ffd5b" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php55-imagick"
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
