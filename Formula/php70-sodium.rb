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
    sha256 "b4199152b62f37af8be60d4906cb35fbc5d80dca50af9e0a317289d4806bc63d" => :high_sierra
    sha256 "6877d35baac5b94d71c122a70779b14073c32590b5d69f70ba8ef2be40740d65" => :sierra
    sha256 "413bdff00df34c54066872fce1fcbb934d179e2c66223344d4fdd7d420fd2e03" => :el_capitan
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
