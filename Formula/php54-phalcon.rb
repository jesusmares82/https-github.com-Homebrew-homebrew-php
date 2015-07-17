require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.5.tar.gz"
  sha256 "7288dcaf55c11e345f2f15a609ff22029365d2597de321f74d7af25ab39128a4"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    sha256 "bbf6d69de1628b523715f4af0088c49c3597713dfbfea4cc1746dd4d069c1218" => :yosemite
    sha256 "9fbaec6df63438d8033997b48ed4694d32cecc0b44ab14ecbea34cdcba6f89cb" => :mavericks
    sha256 "84726d2aa1759affbfd36ae732f84ec0b941bea7049c9980d359402eefced974" => :mountain_lion
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
