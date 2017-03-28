require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.1.tar.gz"
  sha256 "430359e0103ac926861976815d5f1d1373c6b1d7317e128359409aafd4285f84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f0c016937233b7810c0eacb2741d948b8fa0b10c314d2c4b408fea7530dd1ff4" => :sierra
    sha256 "97ca5d995017c777a41d03b699b45117cfb8c9a4e412fc23b0f5587e2f86a9d3" => :el_capitan
    sha256 "0b6c474f1ba3b7223e3210883b04420624986489825c37efaeb61f3500c0ae8b" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php7/64bits"
    else
      Dir.chdir "build/php7/32bits"
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
