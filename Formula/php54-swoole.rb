require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Swoole < AbstractPhp54Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.1.tgz"
  sha256 "d63c5b9339a86df43b0e3d82efd194ac6f7b25f601580a7abf9305e3a6afeb20"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5dcacd829f83de2b8cfcb31bf40f5ba338f89412f6ece05fe4744162f95b4ac5" => :el_capitan
    sha256 "97ef45c4c422d316ea5e8ab03e29ea2fe042b966ed802bc8d01a85b9d14ea694" => :yosemite
    sha256 "b9e47c1e58ab56da75b9f5f0848881955b75c0ca4b19856f98113c9e589b37f5" => :mavericks
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
