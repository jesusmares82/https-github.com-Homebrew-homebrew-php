require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "27a30369b7e320a5d07184712cdecdb445feabb32616143ca2abc73b4059aa8e" => :high_sierra
    sha256 "12ff2763fcf8536f0e1047d3ab7a31497aa285a1071826a1a4e009aaa1e7300c" => :sierra
    sha256 "0f5150555bcf071457d92993dd78af4dc2ea24c6b41961f75f84df3b478c69bf" => :el_capitan
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
