require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.7.tar.gz"
  sha256 "45d02149688cd66857d2414a1bbe1354164266a3f5dd8f77fa7fe6f238dacd4b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "df486aee50ecdf85ea0c8d8afbd805140e3256b566a175c8cab15e3ac410931e" => :yosemite
    sha256 "2e75b450a65f7edb443a62af1014c0426135b97f914602ffc4532be1764afc21" => :mavericks
    sha256 "1c434a143fae2487f0288349c1bfc74109391d381913fc9dc405cc088d16e1cf" => :mountain_lion
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
