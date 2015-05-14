require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.1.tar.gz"
  sha256 "f5bf0048c0096b447362d12f37a8d65feedbc35544b44bd97909e3f1d1d1a42a"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "0b1bc9cc384a00cfaa6916fafdd2f14d1920907d93e088b019dca64442637a54" => :yosemite
    sha256 "1ee09599a201ff49a96ebabaaf0a097a754fa8321bf6c639b96dcb52b116506f" => :mavericks
    sha256 "57848e2b5bc83195a056492813b11fd271bf6bd0787d6d47071e8d8aa0a1c298" => :mountain_lion
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
