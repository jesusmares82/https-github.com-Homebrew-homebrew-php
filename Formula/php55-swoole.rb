require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Swoole < AbstractPhp55Extension
  init
  desc "Asynchronous, concurrent and distributed networking framework"
  homepage "https://pecl.php.net/package/swoole"
  url "https://pecl.php.net/get/swoole-1.8.8.tgz"
  sha256 "e464d669c3573336cd59a96662d43a0e13538dfb335a67c6afc0ecaba92c8c4d"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "04c85b7ba9d365556840d671a4317e6b1171637d6b6ca2b9aa0cd4b7c9e18653" => :el_capitan
    sha256 "8272e7be211232b1dbe13fb413d543b2313647f1800da93e1a758cf29af047e5" => :yosemite
    sha256 "4283a76417e61ca976da3802ea0cb81e1982d135fa4d51615221a68a6b75f962" => :mavericks
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
