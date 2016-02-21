require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.10.tar.gz"
  sha256 "59fbe5bdee7a955ecb1f0cd8bb4c942e33105080302f239363aa3941e9e52172"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d101d1cf7647cecd6fc7220e89a2fb0b62c1e75e8ecbdb17c8dbb0524e87ec9" => :el_capitan
    sha256 "54c403e0bf32783121ccef133734c0b335f2c3e9ce1556e15dd019baa91a5638" => :yosemite
    sha256 "ce8f422812e18d149722b2e9747ad3a37881d5cea1c8ddc562628a0e3650b1b8" => :mavericks
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
