require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Swoole < AbstractPhp55Extension
  init
  desc "Asynchronous, concurrent and distributed networking framework"
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
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
