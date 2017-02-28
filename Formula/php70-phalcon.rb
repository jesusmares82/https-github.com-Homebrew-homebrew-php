require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.4.tar.gz"
  sha256 "50834275cd964a5d1fdd7a588183ca4e038a46900045a6cf91f50b56664d15cd"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "3f1c1c0a1e5d76ca95d495e29d4472522b78e097b7077ba7bfde2902c9d9a88a" => :sierra
    sha256 "7161e4302a7d90bedeff94d78463e0da314b0c47531026a2be278e7cdee55323" => :el_capitan
    sha256 "753c01e8652f6382d53763468fef7780cf900b1a55db03216b3ba4bf335ae1b0" => :yosemite
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
