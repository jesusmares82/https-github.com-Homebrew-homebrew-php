require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  homepage 'https://github.com/swoole/swoole-src'
  url 'http://pecl.php.net/get/swoole-1.7.9.tgz'
  sha1 '51fe7228a2a450651798038aaa3cad65d08a23cb'
  head 'https://github.com/swoole/swoole-src.git'

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
