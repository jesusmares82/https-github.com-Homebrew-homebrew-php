require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Swoole < AbstractPhp71Extension
  init
  desc "Event-driven asynchronous & concurrent networking framework"

  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "18cfb60c83c38ccec5f7b2d12efe6bfd4e143b4c373d8ee70503bc8bf046e593" => :el_capitan
    sha256 "3039983e0c15d039517018a08a81a1bfd46c2168fb15dd8c3f7bb251af650d00" => :yosemite
    sha256 "ab39f39e26abc1e1ffe8fd92ea09be1b90d984eba0abccc31e2ac6beb128a253" => :mavericks
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
