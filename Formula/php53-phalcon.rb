require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.5.tar.gz"
  sha256 "7288dcaf55c11e345f2f15a609ff22029365d2597de321f74d7af25ab39128a4"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    sha256 "2200bc39d103fa256f324fad080735aac7aeaa1a71af84f8e3c63706bb4933d3" => :yosemite
    sha256 "bc1191795743f75166faec9116048f2d91eb321e5ec7d7d5e43653474bbe9b36" => :mavericks
    sha256 "f6af0004fbb2c74ccb88c36aa8b22b955e4c98b2d5305c4cbb7abf03ff451b5c" => :mountain_lion
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
