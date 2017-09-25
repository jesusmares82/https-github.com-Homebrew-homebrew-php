require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.2.tar.gz"
  sha256 "b6eb6ba443b60dce547c17dcaae464305fe35fc36d18347159abac835e34fe71"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6a6e377684851f4190681e0b86dc49e9bc4cde0ef081f342f519f4aff2d1f956" => :high_sierra
    sha256 "174b354ca24e02c85c16308d65fb3e5de6ac3fe715703d0b40eeb165c9394a92" => :sierra
    sha256 "043097e897326b0a9855330d41830b8f73bc86e9e58fd8b960b8b091ff45f369" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php5/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
