require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Sodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.7.tar.gz"
  sha256 "9967a78900a9502f06de02b1516bfd6bbc85cbf20d2dbce032943dcb55728047"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "950f8daa78127312e947db074792848039850b8b866dac6902d099554e9055ad" => :high_sierra
    sha256 "51f993defcb4d95b4ffa3c4845a330dd05e1a2a4fb2116af8a22b3f6b3f0c1ae" => :sierra
    sha256 "ca9e88149b120088a2092d9563e56f530e1308480af95d9d235c7ac6d2da2d38" => :el_capitan
  end

  depends_on "libsodium"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
