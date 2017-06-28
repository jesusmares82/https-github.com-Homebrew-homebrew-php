require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Hprose < AbstractPhp72Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.5.tgz"
  sha256 "a453053719dad6352d54543d708d8d09b62de28df7b29fd47b4b5a9fcf8025a7"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2af042593ef131cf9fa97315bc05603022d467e1d9aebfefc55445a256fe3b71" => :sierra
    sha256 "64977ace22be2783a8f784edaa2579cfaed7da5aa3f3b9fa986a0f6c33124ff6" => :el_capitan
    sha256 "baec131ec446925554b515c80ccfbc02b3da3ed7fb63e31b6032fd75ccd5fbdd" => :yosemite
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
