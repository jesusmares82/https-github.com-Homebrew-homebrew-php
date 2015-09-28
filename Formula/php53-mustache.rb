require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mustache < AbstractPhp53Extension
  desc "Mustache PHP Extension"
  init
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.6.0.tar.gz"
  sha256 "56d0057929fb2f0381efc84c748cc7454f07f4cc55064ffb3e723cc1408d6686"

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
