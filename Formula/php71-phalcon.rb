require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Phalcon < AbstractPhp71Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.2.tar.gz"
  sha256 "da619cab5979b3592b5e880a5e286e8d59841e911000be944fcddb030a7af587"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "25330d34b4c77d99d2ca76b2970cd5ac9c76d796dd249f4c2347fe4fa1655d36" => :sierra
    sha256 "328a30e436e9098d0e022f3a658f2114ddeb1c0944afab54e51bedfbdc951c87" => :el_capitan
    sha256 "b5e36539b99119013da093ba343b6c6657f9e501d6cc333ec9aa7721ce0d4f5c" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php7/64bits"
    else
      Dir.chdir "build/php7/32bits"
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
