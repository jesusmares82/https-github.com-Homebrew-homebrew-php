require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Swoole < AbstractPhp70Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.1.tgz"
  sha256 "d63c5b9339a86df43b0e3d82efd194ac6f7b25f601580a7abf9305e3a6afeb20"
  head "https://github.com/swoole/swoole-src.git"

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
