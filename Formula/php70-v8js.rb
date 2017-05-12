require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.0.tgz"
  sha256 "c9401ed72a14e332661f64516d7ab13fe39c726e9c283cb3c81ccd786309494a"

  bottle do
    cellar :any
    sha256 "04a05a47fff324d989f244a05dcceed61167c517ec8fa485b576ac7cd65eeb68" => :sierra
    sha256 "ee57c527aef2c41ddc94cf1bf05c83bdfe08e413da45b40e9527eb092a24066b" => :el_capitan
    sha256 "141bd8976176fc621ea20a44c56b866a6b35f4b12afc08fbb723cabc30f9f932" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
