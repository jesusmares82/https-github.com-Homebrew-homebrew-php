require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Phalcon < AbstractPhp72Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "48e9b70209119372c328a62fd375997f4b1b18b4e6797851709fadad51921ab8" => :sierra
    sha256 "c6d9fcec5a685b27ef30ed302b79ecb82a556d8fde9b87e96de00b110620e3a9" => :el_capitan
    sha256 "cb2ba950e518fe5d3c0f3a79d02451a66f15dc512042a2907d8807f2b27e0e8e" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
