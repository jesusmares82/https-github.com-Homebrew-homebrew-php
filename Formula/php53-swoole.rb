require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  desc "Asynchronous, concurrent and distributed networking framework"
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b4518b8416b414b3fee00bcbfe1dc91e1dae60f546d082eb07f015c5616795f0" => :el_capitan
    sha256 "b7e357be055a672827b1fc93dea4b628a1363f334ab6a715eee2d24b82047126" => :yosemite
    sha256 "2a0f49cbab40d83bc663e7b6090d55117673d1864424ef12e3767b702534da25" => :mavericks
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
