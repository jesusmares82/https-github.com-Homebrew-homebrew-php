require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Binpack < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    sha256 "001dc0cdd35321f3e068466480e74db02e13f26c8917ab65d4549facef4ef3f9" => :el_capitan
    sha256 "20bf0560d5e4c40c72d9a3d31d1da9284062a6128479fdc9805960800c5ed0e0" => :yosemite
    sha256 "b881cacb75fe25a4ff9a672d54d748db5dbc2477b179171674588097073ee67b" => :mavericks
  end

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
