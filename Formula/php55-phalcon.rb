require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.1.tar.gz"
  sha256 "18b24b99759523b8a6423dedb00fdbaad25fdd0fc3f76428987852afba081719"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4f7f726c818496732bb9545067ecf34b863cf14f0fda8f0acbc7ed6de95ee417" => :el_capitan
    sha256 "e71558418b2f0341ca6c7565982c1b6977eea4c13f5d1009613293c1ef12ea1d" => :yosemite
    sha256 "7f533fe21c7c727b6d05f2af02b354833a4d25a7005657d5c8d43ba26652f97a" => :mavericks
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php5/64bits"
    else
      Dir.chdir "build/php5/32bits"
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
