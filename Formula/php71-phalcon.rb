require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Phalcon < AbstractPhp71Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.0.tar.gz"
  sha256 "32f83fc7ab4eeee37a6577e5920ed5d94f455c723cf9499d195fad3be30c104e"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d904d3418c0629edb333f052e9e182dca73243b84c718a1c1c7eb09c52c29b6" => :sierra
    sha256 "20d0e5cb601388077d03bcc8b584d2ad8791ec5b08eb1fd50b6c877dd55a0fe8" => :el_capitan
    sha256 "c166321ba09d928d0805dd8fe5f3473bf54c923be244aa5643df7426eedf8800" => :yosemite
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
