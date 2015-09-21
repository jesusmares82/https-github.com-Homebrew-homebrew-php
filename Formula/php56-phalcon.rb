require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.7.tar.gz"
  sha256 "45d02149688cd66857d2414a1bbe1354164266a3f5dd8f77fa7fe6f238dacd4b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "f355b01178d281b20fc1302ad46cfd89febdb8bc884d3a9220db9fd032fb9064" => :yosemite
    sha256 "e0c6aabf097090883ae48fe6cc9d1155ecc802c5ea69785ce3591b2331586203" => :mavericks
    sha256 "151ed7598718193ec116440c803d694db64106f6ab9602baebd5c1d99516972a" => :mountain_lion
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
