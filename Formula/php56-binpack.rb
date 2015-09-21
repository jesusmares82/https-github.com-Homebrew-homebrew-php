require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Binpack < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    sha256 "6a8b8a820d3b63d84b396735c9a4451d458245658de6f38ccbf7f2720e086c8d" => :el_capitan
    sha256 "5c64ed1a29b041910713ce984be232099494a0150b86e467d15f9e9765082688" => :yosemite
    sha256 "516bb468326d2071f813e6a48de02dbcd494bf09dd4c63ea3b919acbc2708442" => :mavericks
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
