require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.1.tar.gz"
  sha256 "18b24b99759523b8a6423dedb00fdbaad25fdd0fc3f76428987852afba081719"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6e65296bf56895083040e7328e3c1220bd1e6bc7dfac794008dd9d1637d88618" => :el_capitan
    sha256 "0003173ba852fa837b64ccdddfcd99411833ba2727e2f7fef772e845177fd128" => :yosemite
    sha256 "514766a02552dd8bcefbc638216271674d6faf6b3c25453998fd657a50e81930" => :mavericks
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
