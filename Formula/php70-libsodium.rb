require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Libsodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.0.tar.gz"
  sha256 "780b2a3424ad5a489df48021bb7f422f828b86cc2d5619de8bb5b63b1a3636f9"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "a094c24d56bf529ce9c4f3c7533aab78044b6e1d5a5792e1a268e57c922a9aad" => :el_capitan
    sha256 "a571956e4fc2da99ed4d0c7e20be186731d7624a7ee20d9691f242ad1473d25c" => :yosemite
    sha256 "46213094f7ba956756ad445e2cebe82bb918c66e29fc1cf4c7193670a7621ed4" => :mavericks
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
