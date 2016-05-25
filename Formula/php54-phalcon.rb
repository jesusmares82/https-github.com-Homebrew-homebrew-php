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
    sha256 "f952062443db31ba3431955df591e13d168d002c227924268427d270d33e631a" => :el_capitan
    sha256 "d5749eb6918980eba38ccbd2e489cc1680b27c8afe588da110776dc069dcbc02" => :yosemite
    sha256 "7e73305740c816a38afc507229603d70ec7643dcaa2c088ee01787e4a7bf9011" => :mavericks
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
