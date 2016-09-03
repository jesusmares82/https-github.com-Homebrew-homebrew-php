require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.1.tar.gz"
  sha256 "18b24b99759523b8a6423dedb00fdbaad25fdd0fc3f76428987852afba081719"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "125c24dd7ffad684002fb16e5732036e47129fbaa1192895a3eb414f98b28d4e" => :el_capitan
    sha256 "a5551d0b34264b638618af5d9f2afd83dab97a8e4dd3be11a4d49bb7a8878867" => :yosemite
    sha256 "59cdec32aa4fed0119c17699e1154cf693d5cc0d88e0ae25145c4dc495aa607f" => :mavericks
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
