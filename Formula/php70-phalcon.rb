require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.2.tar.gz"
  sha256 "b6eb6ba443b60dce547c17dcaae464305fe35fc36d18347159abac835e34fe71"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "12fa488c0cb489e5850220876ab186c5311e21f834154cdef8fbba16c98ef88c" => :sierra
    sha256 "e070fdcb41059f3e82a64343197628fb86971c5dcfb76f21f6aacd8c0b298529" => :el_capitan
    sha256 "12b4423bb4ed7eb4fc57d2595258131ab92c125a8a9ecb67cf6758efb8cfaa1a" => :yosemite
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
