require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Swoole < AbstractPhp70Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.7.tgz"
  sha256 "c2b6fc556b1d4508aacd237f7843b17c3313b72202e3aba2f6ae57eb88061e9a"
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
