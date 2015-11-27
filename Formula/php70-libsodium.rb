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
    revision 2
    sha256 "30a13db0659ad6a679759ee8a5e3714b49720380440e5aa53edbbc27aa1f1954" => :el_capitan
    sha256 "159d2b59df2705e63bf65b0be743b38b030ba9c906a56a6a94f09df6c2f01306" => :yosemite
    sha256 "58d77682d67bce672345b23adb9efff763fc19756728639d6a860d81b9ac422e" => :mavericks
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
