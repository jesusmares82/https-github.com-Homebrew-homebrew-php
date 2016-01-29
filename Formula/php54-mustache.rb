require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mustache < AbstractPhp54Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.0.tar.gz"
  sha256 "d01f9969e890f1aa0033c62d06495fa3273c33b02d24794a3f51831200284674"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "ee010bcc1eac6e4d83d34ae86544caf20ecb52243b058437a195ef5d261f2e64" => :el_capitan
    sha256 "1ab02f2b39e9b1e8af102dfabe5be645458736e912ecbd0e759370682ac2aaa8" => :yosemite
    sha256 "f98b7312cda934eb99c467fb31af913b6ff7e2c5cfe8199d5ca0bf0c122b7d22" => :mavericks
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
