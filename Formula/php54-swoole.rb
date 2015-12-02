require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Swoole < AbstractPhp54Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.7.17.tgz"
  sha256 "e4d3c2466aa1e1c99750ec5497445bde8ef775fd0b304d11016e6df363cc7ec0"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    sha256 "5b324d211a10e08f09d6a4ad13c9e044e8058b73ce6dfee75ec12367b31afa3f" => :yosemite
    sha256 "45ba76b0177896087d87b43bdeb92666e1c7cb1a9892533aaa7edaf85a259750" => :mavericks
    sha256 "732f01cb4417633270f3b809e721d449ec0fb0ba5b78efc058901496974e21a8" => :mountain_lion
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
