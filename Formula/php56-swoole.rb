require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Swoole < AbstractPhp56Extension
  init
  desc "Asynchronous, concurrent and distributed networking framework"
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7b9d6267c7c5647848cddc3b598c30ef83dc8bc86124dab5921d82625eb43c87" => :el_capitan
    sha256 "5527668ee235151e21b4a8e371f008eb53df612d1b3579cb9aad07be030d1027" => :yosemite
    sha256 "f80f03228712c015e0ac11ed6d5fa6bad6dde08afbcf2bd94b2d1d17fda2a834" => :mavericks
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
