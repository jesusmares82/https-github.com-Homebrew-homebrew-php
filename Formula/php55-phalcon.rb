require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.5.tar.gz"
  sha256 "7288dcaf55c11e345f2f15a609ff22029365d2597de321f74d7af25ab39128a4"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    sha256 "053e0d45d8d7b3c4444df4834f2f1933e48fb42416a97e7133afec10c566e9e0" => :yosemite
    sha256 "4d508932d04d65180c0bdfd98b71c69b5211807f2484957a59feb6d0838a21d8" => :mavericks
    sha256 "fb77dd544e70adec5bbe01e7d66eb8bc2bb14c0d9588aed00c1010501a246ed6" => :mountain_lion
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
