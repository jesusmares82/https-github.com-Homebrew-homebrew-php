require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.0.tar.gz"
  sha256 "3b54e6ab1e91aecd606c93c2f762549cd23bad2eef35a3100243ecf6ba85a5c5"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "43eba80adea45af408e3596d5ec6496980407708cd0f87c264b9249d5b40e065" => :sierra
    sha256 "7a9ffc59ce90dd75db865797e0baa1f21b013ac95f4d5864ce883074d9a266ed" => :el_capitan
    sha256 "971b1963996decd928b1e48633f6eb61c1c2380f1b0ff239b4d8636c7b46c478" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php5/64bits"
    else
      Dir.chdir "build/php5/32bits"
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
