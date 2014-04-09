require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Swoole < AbstractPhp55Extension
  init
  homepage 'https://github.com/matyhtf/swoole'
  url 'http://pecl.php.net/get/swoole-1.6.8.tgz'
  sha1 'fd45cc0e34ccbcf1060b2d5e8a816b241b8b3ef9'
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
