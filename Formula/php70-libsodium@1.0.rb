require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70LibsodiumAT10 < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.7.tar.gz"
  sha256 "b66c795fa39909eccbc4310e6e9700230e5ad9e8e9d7fcf79bb344dbf9d2f905"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "4bae0ed5e848b2796f5b1ee4b9387202bf073f59fb4c668c05a9f083e34d2488" => :high_sierra
    sha256 "4b89ebd33f69633f40a9d08137ae6f25f6c67e7ab5fcf79b67c7b638232af30f" => :sierra
    sha256 "aadc58d407edd8bf144e4bc9c2d155581f530b51c78e6b65262df53713bbe168" => :el_capitan
  end

  depends_on "libsodium"

  def extension
    "libsodium"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
