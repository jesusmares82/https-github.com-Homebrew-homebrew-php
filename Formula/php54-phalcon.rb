require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.6.tar.gz"
  sha256 "5bab4f86a9a1fdbad3539da43771514a0a437d6fad6c42bc11f14d1f155b23ca"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "5c382cf7079de923a2b36c3de58d103f0ff9481b51307d63cbcb0484d0510383" => :yosemite
    sha256 "a59cb003b93753860d139948938d3e3ca0eaec3740ecbcc3e47fa7a4496665ec" => :mavericks
    sha256 "6f710705de73839522c216ae9d2a6782e7d629d4fb3851d415bc9b00600d268b" => :mountain_lion
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

  test do
    shell_output("php -m").include?("phalcon")
  end
end
