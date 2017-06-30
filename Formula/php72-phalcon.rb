require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Phalcon < AbstractPhp72Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.0.tar.gz"
  sha256 "32f83fc7ab4eeee37a6577e5920ed5d94f455c723cf9499d195fad3be30c104e"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "23326e3cbc7cab588492f6b829620df790ead135c2bd6e1331c312c50f94fa94" => :sierra
    sha256 "cbf85b388aebe108b4e8dc0c2888b71a2593559f2a020cac601c54b9921dd35a" => :el_capitan
    sha256 "543008a7186665d1e51d810480026d64246a4d3bafca7b179a5cedbd7d990dd8" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
