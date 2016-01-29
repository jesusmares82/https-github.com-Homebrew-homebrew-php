require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mustache < AbstractPhp56Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.0.tar.gz"
  sha256 "d01f9969e890f1aa0033c62d06495fa3273c33b02d24794a3f51831200284674"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "c641699cfa7b17040410c867774f715b654e50b3876c0740219a1216b07b6330" => :el_capitan
    sha256 "dec39fc5ac9c0421395e5fd3b7d5f618dc8d1def98fd8fb94a6d8fc4ad5099e1" => :yosemite
    sha256 "954094a08eb7e808fa4f1d93de455327c720a50999202c75b0e8efd69ee5b154" => :mavericks
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
