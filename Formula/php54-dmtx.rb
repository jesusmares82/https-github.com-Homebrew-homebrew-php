require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dmtx < AbstractPhp54Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 4
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "3a6aec7111793efa9e67aa9e9bb864d4617ed7b058b3077abbcd5d878f58b4be" => :sierra
    sha256 "6bf2902c8067e6330e97f7720dc27bf7a2c4bb8e59012aeb575b400397016a53" => :el_capitan
    sha256 "4fe4a14a3cb51d44d436f2a8f7d8bb5f413fd75552664fafea151f37e1086071" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php54-imagick"
  depends_on "pkg-config" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
