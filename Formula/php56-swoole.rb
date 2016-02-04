require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Swoole < AbstractPhp56Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.1.tgz"
  sha256 "d63c5b9339a86df43b0e3d82efd194ac6f7b25f601580a7abf9305e3a6afeb20"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4259801e506eea282778bb24d75b3478cdc184744501db4e0bd66ccc4388275b" => :el_capitan
    sha256 "39b2c75f336c1479b884dbd025230cd8d45865ab482d0e843067b5d1244a1eff" => :yosemite
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
