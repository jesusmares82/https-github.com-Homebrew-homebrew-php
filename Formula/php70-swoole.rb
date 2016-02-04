require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Swoole < AbstractPhp70Extension
  init
  desc "Asynchronous and concurrent and distributed networking	framework for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.1.tgz"
  sha256 "d63c5b9339a86df43b0e3d82efd194ac6f7b25f601580a7abf9305e3a6afeb20"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1abd9e8969c1e7d6f7d041b64a6309a2fc48c46c4890b8d88a6e62967c3d9a16" => :el_capitan
    sha256 "de09c35007ee1ab1794e1f406999ba7f5daee7fe30de6525367f913d5e3419ec" => :yosemite
    sha256 "448655a86aa48dfd5c2154e5ae3554ecec30bc6cfc664389981cd11c875658de" => :mavericks
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
