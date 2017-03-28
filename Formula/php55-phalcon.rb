require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.1.tar.gz"
  sha256 "430359e0103ac926861976815d5f1d1373c6b1d7317e128359409aafd4285f84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a6829c7db09821ace350a7ee6b24c427b47cd7e4e90aac6c04d7f581034b39e0" => :sierra
    sha256 "cc5d57b4cd931de99d3c4d12e5a52d48f816adf8d3faa5fb0931aaa58e5f8ac7" => :el_capitan
    sha256 "a02d1fd25993be1ec65705eeba9429e4e24436fef41dc208824275a33eb0a25f" => :yosemite
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
