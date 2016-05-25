require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz"
  sha256 "0a1bd6afe902c6f2f68cf5e2f2785503f5ad95d1d2cf1b66c77154c483a08a35"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f29845e85b009f6ab2b41a16f25473ae91fe0ff9fe639fc9cf01da4b163f187" => :el_capitan
    sha256 "48aca65a198184d1425c952294f398e6623b28d7a8d41b75177ec974f5b48b8d" => :yosemite
    sha256 "42bdf6d3753a6dfdaea424e060434a941dffdd10d9c88139bb7cfc2f312b7952" => :mavericks
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
