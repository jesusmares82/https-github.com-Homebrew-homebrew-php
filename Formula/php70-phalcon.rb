require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.0.tar.gz"
  sha256 "32f83fc7ab4eeee37a6577e5920ed5d94f455c723cf9499d195fad3be30c104e"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0e11228e8b3cc64c00bfce946eddfa61df6e27f03cf266457a6e6a398c5dc2d0" => :sierra
    sha256 "97b519399d7afe7f0c9bc27e31a1b4b69c0bcda3fd2a8f0b7532f9a106d4d9c8" => :el_capitan
    sha256 "26a6effc5b0456b40b116be06e315b4f087adf3a3b07c30d1acda60f1aa5f153" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
