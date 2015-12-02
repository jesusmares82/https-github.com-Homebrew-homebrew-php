require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Lz4 < AbstractPhp53Extension
  init
  desc "Extremely Fast Compression algorithm."
  homepage "https://cyan4973.github.io/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    sha256 "c03a0241c62d3b2f09eecfcbcd7d9de13afed3612421b1fbd87375ae2099cb14" => :yosemite
    sha256 "d7f3be38cea697816faa7fd19575d40395bd457f33a634f844505e87812702d9" => :mavericks
    sha256 "d183f3afa2480d325fb9bca68d4175aab4de11c59d1ef0c379c603a22536ec05" => :mountain_lion
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
