require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.8.tar.gz"
  sha256 "ff61532ebb5dd99c43ce0ba508f0f37b87607f24fb7f595268dbe6331f3c906b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b3ec2f2db2c1c936469502cc75f3399508a95ef0d0c022cddc6e8ecbce01d94" => :el_capitan
    sha256 "97a6b20709c58eb5a228814f190af1232d6360af6e5bcde1d359bad1ff47696f" => :yosemite
    sha256 "37b18b10b1db88e33dedb395c12ed927af565d33989a1ff707def359f3958292" => :mavericks
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
