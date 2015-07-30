require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.6.tar.gz"
  sha256 "5bab4f86a9a1fdbad3539da43771514a0a437d6fad6c42bc11f14d1f155b23ca"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "be95e91e91cf82da79727846dbf2b63c43a808c4d4f238afa8a60c3b9ca0d176" => :yosemite
    sha256 "4a5b9fcb05823cb051d53a5225d413384f827d1f848d575c2c1efc1068cb0582" => :mavericks
    sha256 "37c00c2e08c662961631e6e7112f112d14a852895675bfb337e1e62c2413b4a6" => :mountain_lion
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
