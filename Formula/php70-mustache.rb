require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mustache < AbstractPhp70Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.0.tar.gz"
  sha256 "d01f9969e890f1aa0033c62d06495fa3273c33b02d24794a3f51831200284674"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "8154f07c0aea19269075b504649a753f35e6ebda17585bad42e1dc73ee67872a" => :el_capitan
    sha256 "64575366b6ff66745d8258169311f9ad57ba2d0f554d3836078186a9a0c47920" => :yosemite
  end

  depends_on "libmustache"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end
end
