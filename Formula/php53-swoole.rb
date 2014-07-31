require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Swoole < AbstractPhp53Extension
  init
  homepage 'https://github.com/matyhtf/swoole'
  url 'http://pecl.php.net/get/swoole-1.7.2.tgz'
  sha1 'a6cab2378246bb0ce160f46eb992351b9df03cd5'
  head 'https://github.com/matyhtf/swoole.git'

  def install
    Dir.chdir "swoole-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
