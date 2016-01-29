require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mustache < AbstractPhp54Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.0.tar.gz"
  sha256 "d01f9969e890f1aa0033c62d06495fa3273c33b02d24794a3f51831200284674"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
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
