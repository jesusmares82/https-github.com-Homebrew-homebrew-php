require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.4.tar.gz"
  sha256 "50834275cd964a5d1fdd7a588183ca4e038a46900045a6cf91f50b56664d15cd"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a6d40d551fbc6f1e593df7e81f9b7575ba6053ea9cb2ea2d42d8a349287c3c62" => :sierra
    sha256 "7153dc0e19d6754bc8c596858904e8ee15ae776a4ad4b1038f26b2db9b56c18d" => :el_capitan
    sha256 "c5e639e6c5d3f1e731038977cb32de47c7b4226669846a7e46eed1742a72a6fc" => :yosemite
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
