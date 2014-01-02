require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Crypto < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/crypto'
  url 'http://pecl.php.net/get/crypto-0.1.0.tgz'
  sha1 '91294bbbc672782899a980001519a25b58041e09'
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
    write_config_file unless build.include? "without-config-file"
  end
end
