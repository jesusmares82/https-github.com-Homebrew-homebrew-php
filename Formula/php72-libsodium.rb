require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Libsodium < AbstractPhp72Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "5384b1b00122cbd7733c877c116d611c33ef935a27341b9b977852e20b7f5413" => :sierra
    sha256 "73f5097d3128f7160abbb9a3745801606b8f9003cf42d25b2a3037bcdcf2f0e7" => :el_capitan
    sha256 "e84a650fdc7725f417ad6b053e4c1da2cecc8d5a409f2346f8bd7ec812adedeb" => :yosemite
  end

  depends_on "libsodium"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
