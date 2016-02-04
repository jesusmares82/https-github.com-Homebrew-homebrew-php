require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.1.tgz"
  sha256 "d63c5b9339a86df43b0e3d82efd194ac6f7b25f601580a7abf9305e3a6afeb20"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "525c310ecf84db032e678037d6023c9400cdd7eb5b2d33ec031346ea4c414059" => :el_capitan
    sha256 "7d9854c34d4c8681c3bcf9da2a408596b4f13096f38a6192b03a9662f2e6df3a" => :yosemite
    sha256 "bededfe6b0926ab572be4d25401552119856458c956ebdd61ce6af3656e8461f" => :mavericks
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
