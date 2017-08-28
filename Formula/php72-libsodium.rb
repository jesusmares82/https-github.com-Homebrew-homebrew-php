require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Libsodium < AbstractPhp72Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"
  revision 1

  bottle do
    cellar :any
    sha256 "524e2daa1994fd68f34b1b0dacb2bab617ee8dafc72810f604a6d3d698ed8c4f" => :sierra
    sha256 "a5a93fd50f8c92a75d992a17e749a71398788696576f53b1a0ec317090d58119" => :el_capitan
    sha256 "aedfaade7c76d931c9c4ab16c8b653f46d8954d42a3ac6202cf3185dc5202142" => :yosemite
  end

  depends_on "libsodium"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
