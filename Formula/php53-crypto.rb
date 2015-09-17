require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Crypto < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/crypto'
  url 'http://pecl.php.net/get/crypto-0.1.1.tgz'
  sha256 '9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b'
  head 'https://github.com/bukka/php-crypto.git'

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
