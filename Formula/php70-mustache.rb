require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mustache < AbstractPhp70Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  head "https://github.com/jbboehr/php-mustache.git", :branch => "php7"

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
