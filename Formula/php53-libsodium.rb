require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libsodium < AbstractPhp53Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "42f95d92ab34cbba8349797e1b89a0d3b242099b23d44faa25da4dd49b59f271" => :el_capitan
    sha256 "c08d754f45ad6d63d733384c80cd8b3f9a7d8f62fdc63af26db88ac0d850ac69" => :yosemite
    sha256 "e6381e23ca489afedad5eaad11f6fd6a74534400e1ccf883ae454713415cce08" => :mavericks
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
