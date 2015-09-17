require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Crypto < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/crypto'
  url 'http://pecl.php.net/get/crypto-0.1.1.tgz'
  sha256 '9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b'
  head 'https://github.com/bukka/php-crypto.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "acefe2178ad20b0ba86c6bfb9bc70cdd0121a73dc5e9cc5ef10f1478b1a92151" => :el_capitan
    sha256 "77be9e15db9d437b7a3ab2923d460fe1b58fb13fd8c2f72773e9db01414f1b79" => :yosemite
    sha256 "13b056cf6027e527e22eba68e2584f7532abee1390b117d15866ba8e2e7a6b6e" => :mavericks
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
