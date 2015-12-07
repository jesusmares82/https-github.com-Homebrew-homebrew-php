require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.9.tar.gz"
  sha256 "3f06c2c140b502547920f83e4acb29e1da6261d22c6154ac40b3f81f09ee6b74"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f2713f5479e2c8064f031d8443a70756ba256e1a7063cebd3a90e3495131326" => :el_capitan
    sha256 "d04121696edbe67ac010203b74f42d16920aed8608320b00e9f60fce6971c569" => :yosemite
    sha256 "ae3a3e74bcf33df953554ae1ff681f7b3bc068ddfc4a16a8d93aae1a5af4adef" => :mavericks
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
