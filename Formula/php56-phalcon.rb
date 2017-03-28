require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.1.tar.gz"
  sha256 "430359e0103ac926861976815d5f1d1373c6b1d7317e128359409aafd4285f84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5119682c18a12a9acca779c2205fb849c96d24e5f0fdb3d9a45dfd24d2a09c75" => :sierra
    sha256 "a0e66931f170b1b9d45f8e1da5371e9a8922365e1de3e6ca97bc2135b0ddd39e" => :el_capitan
    sha256 "878042d8afe393d0eb23e8bc367b63daeeb0b5cbee047516043b5e87527d508b" => :yosemite
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
