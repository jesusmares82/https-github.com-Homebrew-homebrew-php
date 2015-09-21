require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Lz4 < AbstractPhp56Extension
  init
  homepage "https://code.google.com/p/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    sha256 "69e0e294dab7b530acad06b13f73f5d1367779c20e7996f4d2601abbc9d9b9f1" => :yosemite
    sha256 "fdf4fb7d915e73b38407c9c6938a6d6419f89534a3d88c47fa17146b3e681914" => :mavericks
    sha256 "18740f2d91a5192aaee53948e484b27751762e7225f734ec43d94e4c5bf0b337" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
