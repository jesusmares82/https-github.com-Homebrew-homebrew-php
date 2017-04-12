require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.2.tar.gz"
  sha256 "da619cab5979b3592b5e880a5e286e8d59841e911000be944fcddb030a7af587"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b5987c1e7b7cb6d760f8540ab3aaca788d2430eaabe9a70f97fecbb9de77ea52" => :sierra
    sha256 "8a30290ae2f77120a3b5b288a0371c294a4436c5a159eb0ab5c7aba59208f5ea" => :el_capitan
    sha256 "3ba38af7135fb191ee798f1611608b594baa3ddb102beb612acd20468354dce1" => :yosemite
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
