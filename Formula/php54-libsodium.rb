require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libsodium < AbstractPhp54Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "fadefa135c33293321208c2794dcd8d5ac255f200bb4cae4a36344ff4697fd8e" => :el_capitan
    sha256 "780984b2fe96ff47032911264a245cf62e7674e78751048c956287007054f3d5" => :yosemite
    sha256 "17b24e4191b9732b6222a532efecdd6a86e6f1df43a014e5fc4672f2683f00de" => :mavericks
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
