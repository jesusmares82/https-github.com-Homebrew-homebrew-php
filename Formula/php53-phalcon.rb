require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.7.tar.gz"
  sha256 "45d02149688cd66857d2414a1bbe1354164266a3f5dd8f77fa7fe6f238dacd4b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "39cdd42ab84331c7fb17a8fa159feef1b3f181bdc50d5b8e6b746518a9faa1ed" => :yosemite
    sha256 "c8d8c7537ea6832cf518dfaeeeced59f277faaf09ff3f3e11b1479cb296b9689" => :mavericks
    sha256 "f778fe3777ce0d42d0574f241e1a386ae849097f9b4f5e9cfc7e4190081cce07" => :mountain_lion
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
