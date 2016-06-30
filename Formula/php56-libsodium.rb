require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libsodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "3c27e7a1bc9e6b92f15fdeba58ee49f9a53ede6ac2265871916168e7886b2d36" => :el_capitan
    sha256 "6f438200eb0cbe31bdf007fb6598735a730c4a3ad581874313ad6ad9a75762f6" => :yosemite
    sha256 "50db7cd8bd25c701062459b9c8f7d8544d9ccf6a3833274fe7a1d51d9b0066bf" => :mavericks
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
