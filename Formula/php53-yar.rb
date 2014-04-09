require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Yar < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/yar'
  url 'http://pecl.php.net/get/yar-1.2.2.tgz'
  sha1 '882937c7892a4252ec03714f783317c4a1df66f3'

  def install
    Dir.chdir "yar-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yar.so"
    write_config_file if build.with? "config-file"
  end
end
