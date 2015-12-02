require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Swoole < AbstractPhp55Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.7.17.tgz"
  sha256 "e4d3c2466aa1e1c99750ec5497445bde8ef775fd0b304d11016e6df363cc7ec0"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    sha256 "8685225437127b23af00ea30a52cd02ccecab5fad26010520695bd71242157c7" => :yosemite
    sha256 "a8c1c83b59512df7c1e09a90bc7e14121b40e63427187d50b7525e2b2b3b8e5d" => :mavericks
    sha256 "00ba5025dfc0a3c6ceeb04f738f66a8cb83d3e9975272fa6e5840add078d3ce2" => :mountain_lion
  end

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
