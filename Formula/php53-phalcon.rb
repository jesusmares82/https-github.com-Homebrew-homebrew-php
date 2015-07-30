require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.6.tar.gz"
  sha256 "5bab4f86a9a1fdbad3539da43771514a0a437d6fad6c42bc11f14d1f155b23ca"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "27b15252d137a6686b144c7d3fff3cb06cef3cef3b6467e38e91050f973a4a62" => :yosemite
    sha256 "8bff5629936c304d8f3e95ceb623fa3cc659d80cbbbdfd037b1a4061aaf1edff" => :mavericks
    sha256 "43066422f43a075a6a075d37959c60f3047eb8d3778e64c8aa88c0ff390c0fc7" => :mountain_lion
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
