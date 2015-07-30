require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.6.tar.gz"
  sha256 "5bab4f86a9a1fdbad3539da43771514a0a437d6fad6c42bc11f14d1f155b23ca"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "d18062c978b1f88c366c200bd6280f75f4c6587cb2100fc8e791febd5cc1d11a" => :yosemite
    sha256 "b8890e38212a6feab259ec0fec7b7360454f8a5354ff55ebac486c15ef8dad11" => :mavericks
    sha256 "24ff3dc37a24c15da2c501909645f3726b7c23c91a461159fa21ac80cd987073" => :mountain_lion
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
