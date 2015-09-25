require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.8.tar.gz"
  sha256 "ff61532ebb5dd99c43ce0ba508f0f37b87607f24fb7f595268dbe6331f3c906b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3584943dde99e34f270b12965e73e101bcf60b32cf9ee0027383ae543c71b68f" => :el_capitan
    sha256 "f0f333e665ce28f2b54e40880e17be040b9e7e078dc818f84f86922cb0735637" => :yosemite
    sha256 "35491943dfae1e0f93b1e23fdfaeea366df0a02b7f4641f923c9fd7565d3b693" => :mavericks
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
