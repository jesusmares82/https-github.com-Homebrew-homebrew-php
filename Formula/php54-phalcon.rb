require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.7.tar.gz"
  sha256 "45d02149688cd66857d2414a1bbe1354164266a3f5dd8f77fa7fe6f238dacd4b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any
    sha256 "c28aa29dadeefef1599ba56afaf4abeab79b2df634fa574e80dc6565e302e853" => :yosemite
    sha256 "c185b3bb72b12f065e765fe9ef5a9f282adf814b205b27c32d3521b194dc93d3" => :mavericks
    sha256 "f460f37e1f8227c29242bbd47b7d574da8bffab6bfcb874b8b255edd0ba921c4" => :mountain_lion
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
