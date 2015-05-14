require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.1.tar.gz"
  sha256 "f5bf0048c0096b447362d12f37a8d65feedbc35544b44bd97909e3f1d1d1a42a"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "cf19aacaf742e07d19eb7cb4a7f6925f3cc20484fb60e4e4900f7a3ccd349a12" => :yosemite
    sha256 "b1c3d48a0b002b0eb1e298f61b1a8cfff152177b2ef8a0a400e4bb9c1b964cc7" => :mavericks
    sha256 "128f6cb5643b6d7507d3c7a95fb29510222bf6211f2ad6c137f350513211b5ef" => :mountain_lion
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
