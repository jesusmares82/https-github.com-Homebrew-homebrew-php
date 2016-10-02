require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Swoole < AbstractPhp71Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d676eed8340a1f921cf7269ff30c301f3e9e496be8d0db68b814eabcaee0bea" => :sierra
    sha256 "1d485a5186b66f5b4b04032d0b2b08d810045b750509e662c2b0caa055389157" => :el_capitan
    sha256 "e75f116cb2e2a5a5a71dbf0e66e547c7bb977511ffde0c77e438b218ef2382fe" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
