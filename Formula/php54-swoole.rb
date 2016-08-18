require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Swoole < AbstractPhp54Extension
  init
  desc "Asynchronous, concurrent and distributed networking framework"
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "81bca117d4edd507ed64dfe18928b3cb3d5cbbcb81d26ec84f09b21a0b887269" => :el_capitan
    sha256 "24bf802a8731ff392d3d2536eaa9984b9163afbc6c3881c53b2cb5d3ed5d5d10" => :yosemite
    sha256 "bf5a4d217caceaaeb9fedf77a7565e463d23107e88bd1ee8ef632040e5dadfea" => :mavericks
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
