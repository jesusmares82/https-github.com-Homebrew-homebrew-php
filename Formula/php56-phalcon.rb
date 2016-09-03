require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.1.tar.gz"
  sha256 "18b24b99759523b8a6423dedb00fdbaad25fdd0fc3f76428987852afba081719"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9c4cc2df1ce2a29828a640e95c96faba55278072021b9994944072e284826e31" => :el_capitan
    sha256 "3bf7020fee0d21a52bd789bb3c1faada91678d24cdafea1695325ff318469790" => :yosemite
    sha256 "061e25fd5801cc9a7431d99e461ddbc390a95c9a2b15976cdfcb59cde186a2d6" => :mavericks
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
