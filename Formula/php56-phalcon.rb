require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.2.tar.gz"
  sha256 "da619cab5979b3592b5e880a5e286e8d59841e911000be944fcddb030a7af587"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "eb3fd64d7a18ad883f5f912a29d74b518f6235ec14fe6cc1053868410aed1b91" => :sierra
    sha256 "4d74263823884d62134f76ec0f36dc98dad57d70a67677611ae6013d205487d3" => :el_capitan
    sha256 "a9896dfa83b9e2d3d49608b3f81b9ce54b526c3eb8874c96089fefb89a932d37" => :yosemite
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
