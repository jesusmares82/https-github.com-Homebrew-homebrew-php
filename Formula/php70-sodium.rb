require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Sodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.4.tar.gz"
  sha256 "872f21f90993b4cbecada0516e49371ca6914c90538e9e41d50fee1187b45f6d"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "3425f456238fa32050cbc15fa94d5ba6a1dbe9b9f310ca18639917867ad4c139" => :el_capitan
    sha256 "b08c9abb4831c729e3cbaf8e25d3ce4afc5a13001e91050bfab044794d52c49e" => :yosemite
    sha256 "21ce16f007bbf2554c6536aa5a704d319dcce40b644e88157c1698acdfe0e670" => :mavericks
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
