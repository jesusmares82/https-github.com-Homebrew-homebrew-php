require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Crypto < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/crypto'
  url 'http://pecl.php.net/get/crypto-0.1.1.tgz'
  sha1 '518454c7898d5ba33713a7a8cf2cb2f6acf68824'
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
