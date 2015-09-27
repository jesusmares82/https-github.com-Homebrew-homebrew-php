require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Binpack < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    sha256 "ecca2f9d45062e1d9d834f7beedc5eab816e897456dacb9c5e42147b14c53298" => :el_capitan
    sha256 "dab731ec233b747dc6cc379f9370fad48c75c47d39f9a8975e4df90d4005834e" => :yosemite
    sha256 "a8be32101cebb5a6bdd94127e7f983bba19221cf91dfac53651559a2369e5be8" => :mavericks
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
