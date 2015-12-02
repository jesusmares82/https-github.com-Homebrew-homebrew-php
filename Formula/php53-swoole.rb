require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.7.17.tgz"
  sha256 "e4d3c2466aa1e1c99750ec5497445bde8ef775fd0b304d11016e6df363cc7ec0"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    sha256 "0cf9cc9752134024f561ab38345e2369f354a8bedba1f89cdd8a90ce293cb447" => :yosemite
    sha256 "0811204648ede7c37b5077447b39dd9c01a08c0e63ec3ad0d185f0aa34fe7876" => :mavericks
    sha256 "4e7157e540ad2fcdfde0318df026965743472c960d50152116f446988a23bb15" => :mountain_lion
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
