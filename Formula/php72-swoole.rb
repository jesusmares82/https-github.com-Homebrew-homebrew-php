require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Swoole < AbstractPhp72Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/v2.0.7.tar.gz"
  sha256 "d8370a5f959f2d4082f5b2cec2e3a5b294dd3d7f586a5c7a19e3d154b48c699b"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "abc58bc95bef5544be86910c48d0116daef2e63695b8750ba4ec918d5b41a4c8" => :sierra
    sha256 "fb4593162589db1c33544c6c6e738b3537eb1addd46673fce12272c83f39c3ad" => :el_capitan
    sha256 "020a3e91940346a82c1c6f2898245788c15e2311e920e10999cb24a3369ddef7" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-coroutine", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
