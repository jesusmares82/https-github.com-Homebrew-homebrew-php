require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mustache < AbstractPhp56Extension
  desc "Mustache PHP Extension"
  init
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.6.0.tar.gz"
  sha1 "4cd4080572b35425bfdf78b012bcc5f67f354bc7"

  depends_on "libmustache"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end

  def test
    system "php -m | grep mustache"
  end
end
