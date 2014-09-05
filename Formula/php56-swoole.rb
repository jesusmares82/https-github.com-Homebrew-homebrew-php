require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Swoole < AbstractPhp56Extension
  init
  homepage 'https://github.com/matyhtf/swoole'
  url 'http://pecl.php.net/get/swoole-1.7.4.tgz'
  sha1 'b09d47d27bf810cc8798384c8f21feb80a2a55f0'
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
