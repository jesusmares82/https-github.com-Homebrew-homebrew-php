require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Binpack < AbstractPhp53Extension
  init
  homepage 'https://pecl.php.net/package/binpack'
  url 'https://pecl.php.net/get/binpack-1.0.1.tgz'
  sha256 '70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297'
  head 'http://binpack.liaohuqiu.net'

  bottle do
    cellar :any_skip_relocation
    sha256 "28bf14adb42d2c5294fd9e902304cb4f9dc8937932c359d2c3fa62dae52c064e" => :el_capitan
    sha256 "53398fe95de44e38c742da84c17af42a6b848f01886f89f8d9679de0492b2bde" => :yosemite
    sha256 "96cd09b82b01fadba79c569012c41ebf6b411734faf1c4379dcb38b517dd2b6c" => :mavericks
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
