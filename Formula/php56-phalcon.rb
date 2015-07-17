require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.5.tar.gz"
  sha256 "7288dcaf55c11e345f2f15a609ff22029365d2597de321f74d7af25ab39128a4"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    sha256 "0b808207f9d6a01c52bc7a4d06d8d76dcaa7f2b89280c87019d7e7d2a78ee73e" => :yosemite
    sha256 "3813be4e146e1a30f610b7b305d21f3a3fff7b4bd0a1ffb48fc7fa5fa3a342ac" => :mavericks
    sha256 "8a679af29e440ad20b699c51a4f0a41cc9dac89ba352f15906f95a6f5029a3aa" => :mountain_lion
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
