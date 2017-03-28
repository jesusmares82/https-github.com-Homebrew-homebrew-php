require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.1.tar.gz"
  sha256 "430359e0103ac926861976815d5f1d1373c6b1d7317e128359409aafd4285f84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c23f321243f4fba9b73798e549d2df052336336c548a23d1d15bee918c43b413" => :sierra
    sha256 "6f1a4c9ad610e752a80092c0761365567e861e0b0939a8c79900a3fc91da9ecf" => :el_capitan
    sha256 "859387ef4582ea38d5314149019e8fb3fa72065ea425a708720755923ff081a6" => :yosemite
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
