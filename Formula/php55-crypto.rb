require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Crypto < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8fa82e628f4b9df8d3f40a30b28ee72fc108f6863057797a0706842fe73110e7" => :el_capitan
    sha256 "7e848e3618aad2e5a11cc8095b7eae6366d5f444167f7760d2c33f7c3317b382" => :yosemite
    sha256 "0c12ed77a1aaa5aa960e6cc5111318bdecb01095f8ba60bf81f6c3d5ccebf1e0" => :mavericks
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
