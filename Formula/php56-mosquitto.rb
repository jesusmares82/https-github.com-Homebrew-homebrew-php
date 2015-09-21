require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mosquitto < AbstractPhp56Extension
  init
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "8f49b14d46c1cd808a0f36c2656ac0ee593a0e7860c00e6a15e4820331b3b896" => :el_capitan
    sha256 "0693897b2f6d29c48880007b94a82561a215204117e71168a39358f7f013923e" => :yosemite
    sha256 "64b31e0c7b62a8ac5ddba8bb0128837000ed9631acd95074a3823a5c34143f54" => :mavericks
  end

  depends_on "mosquitto"

  def install
    Dir.chdir "mosquitto-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mosquitto.so"
    write_config_file if build.with? "config-file"
  end
end
