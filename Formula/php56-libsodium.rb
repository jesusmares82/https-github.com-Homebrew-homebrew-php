require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libsodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.0.tar.gz"
  sha256 "780b2a3424ad5a489df48021bb7f422f828b86cc2d5619de8bb5b63b1a3636f9"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "226ec8c5d9b69102f59977cf39238d1651dd915863116aaa2b1e8aec3e09d84d" => :el_capitan
    sha256 "e5df63029817cdeefbf413d2a2b9ddafca83d6bd06ce25274a4a75a940c4d5ac" => :yosemite
    sha256 "1d3090c23a85df341379a2c09f33d4dd8dd8cda41cc0424f19100566cd2873cb" => :mavericks
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
