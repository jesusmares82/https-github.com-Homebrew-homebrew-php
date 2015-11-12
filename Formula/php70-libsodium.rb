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
    revision 1
    sha256 "0f5e5cd5bc8c56a25856291de9dcb84a87f7cfbb32ecd54cf2f216a2c4c4020d" => :el_capitan
    sha256 "f3f5cb9c349871211e7549fb98018e5fac191f622287e3e45f02713ea8c66738" => :yosemite
    sha256 "3fb31bb0a7851af54c406f04b7587f957c6f8985a2a912de42d65e50dcc42084" => :mavericks
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
