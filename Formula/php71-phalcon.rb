require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Phalcon < AbstractPhp71Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.2.tar.gz"
  sha256 "b6eb6ba443b60dce547c17dcaae464305fe35fc36d18347159abac835e34fe71"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e9c13ba4b6fff138f25ea6b64b1e6963131f47e2d109e033c2372b2239d91165" => :high_sierra
    sha256 "751698875fc0a7dd9a369f8bbb2daca9bdb7b5c97a6e9878da80e63317c53a67" => :sierra
    sha256 "79e957c88f960f2c5c1e2186db4974029ca2b85c0f3719a893591f648dc547e8" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
