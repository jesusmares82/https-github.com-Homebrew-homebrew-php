require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.9.tar.gz"
  sha256 "3f06c2c140b502547920f83e4acb29e1da6261d22c6154ac40b3f81f09ee6b74"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "44c35a8b804410e5cedc75be33e140beea158ccc34a150e81f3804b4ae0dffc8" => :el_capitan
    sha256 "1c445abb68f2966e6d19b029715b2c2913e3c0818d298bcf5154aecb2cff5203" => :yosemite
    sha256 "706fca3dfcee3b39e5519da18ef1571b6beefd10b23df52db20ed1016ba20dff" => :mavericks
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
