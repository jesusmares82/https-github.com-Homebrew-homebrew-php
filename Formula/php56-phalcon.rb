require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.0.tar.gz"
  sha256 "32f83fc7ab4eeee37a6577e5920ed5d94f455c723cf9499d195fad3be30c104e"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "18f429e45b7ae9195c5d8d19e634ecfab159e296d02fb4fe352cb252f8cbebb5" => :sierra
    sha256 "f5554bbaa8e7e4fab9407481304974e75132db05f4060f47c9a7dfaa331de9cd" => :el_capitan
    sha256 "a04ff89fe9f9a1b58dfb0e175bf75c52f81e08b8002c9f2cf8bff6a748f2df7c" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php5/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
