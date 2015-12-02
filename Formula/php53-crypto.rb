require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Crypto < AbstractPhp53Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "60e3d69c23d9533ac25cec9b67529c8bfc88d3d2fefde2ac4f424499498eae7f" => :el_capitan
    sha256 "acccdb2f064289f97bacde2330a99fa0017f1f562fa0f9b47597f769ba8e0683" => :yosemite
    sha256 "b66248614c97b8f57312fd6584665019adb1bfe23a51ed4cfca00ef15615823d" => :mavericks
  end

  def install
    Dir.chdir "crypto-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-crypto"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/crypto.so"
    write_config_file if build.with? "config-file"
  end
end
