require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.7.tar.gz"
  sha256 "9967a78900a9502f06de02b1516bfd6bbc85cbf20d2dbce032943dcb55728047"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "5743a564fb8ccc01c753fc36e9fc9095f70c1372d39c8893a68b1f0c42b6c443" => :high_sierra
    sha256 "502d014dc25d1d463fa9db584f1805a06c08b617aa88e7a3e2c782c35ef20429" => :sierra
    sha256 "f2d52b9f078ab71591541c4af818789457d5168e0004bd42922a45c3fb8573d6" => :el_capitan
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
