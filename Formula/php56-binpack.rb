require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Binpack < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/binpack'
  url 'https://pecl.php.net/get/binpack-1.0.1.tgz'
  sha256 '70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297'
  head 'http://binpack.liaohuqiu.net'

  def install
    Dir.chdir "binpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/binpack.so"
    write_config_file if build.with? "config-file"
  end
end
