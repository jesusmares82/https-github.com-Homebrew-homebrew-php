require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Swoole < AbstractPhp56Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.7.17.tgz"
  sha256 "e4d3c2466aa1e1c99750ec5497445bde8ef775fd0b304d11016e6df363cc7ec0"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    sha256 "f3560a5d49ca5d0b5b27fab63fd5b16e034a592c47afe1c860be38350fd8d286" => :yosemite
    sha256 "8cafb220f5ec6123cad36a8523b82c7855c30acf0406018150915b57f77cc4db" => :mavericks
    sha256 "5107208c3db15bafceaf18d104a91b02539907801e180c3249bc7e23b6e4d9d3" => :mountain_lion
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
