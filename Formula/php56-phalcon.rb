require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bb49704924a2f9174d3f2f00ec4521f8563eafd784cbb05d75747ec96c5d02b3" => :high_sierra
    sha256 "c04c00f87f31bb88d7b749ddc201f0210af370af39ec09fb3dcdcfcbc810c7d6" => :sierra
    sha256 "83b86276b7d22383a27f8a18cb862f6c0eb8a83beaa0cf6ec05c503b07305fe8" => :el_capitan
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
