require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libsodium < AbstractPhp54Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 1
    sha256 "ea66f3b3b401822d01675990251a5cf192670066e590113216e56273084cc7a9" => :el_capitan
    sha256 "f9c4b986ec66909b9bb73291d7cb172f82f693391c1293a2e490066ee1207796" => :yosemite
    sha256 "128e9bf97957d3a6a8086fa0b7f108021eb168d033cce894f828b3cd732c987a" => :mavericks
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
