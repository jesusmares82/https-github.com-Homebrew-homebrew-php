require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Swoole < AbstractPhp70Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "37bb6cb2b97c156aff4a3c9d55f785ace78c372d887e6c9c3e0a49c764be04e8" => :sierra
    sha256 "e03a91d048da2898116ac49825dd736d49eede14fefc5b4306441398f2dab0f5" => :el_capitan
    sha256 "29b7e4b70163670760d634982b7d890e612acc93c3f4cf15bb026fdfbcc321cb" => :yosemite
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
