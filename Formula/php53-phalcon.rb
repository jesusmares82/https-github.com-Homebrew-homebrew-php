require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.9.tar.gz"
  sha256 "3f06c2c140b502547920f83e4acb29e1da6261d22c6154ac40b3f81f09ee6b74"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5561e198d3eb87123d36ac0ae9c1b176970e66b3a648ca8ccd936cdd050b5a54" => :el_capitan
    sha256 "89c1230a4c80928f210bfa4d0f097cf73c9c96dbc43edfc0fc6530b71ce508a7" => :yosemite
    sha256 "13e08228682e68d05a27209ac4e2f51e206019d6804e61d4556a093666ea00f5" => :mavericks
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
