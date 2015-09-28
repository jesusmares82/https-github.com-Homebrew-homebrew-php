require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mosquitto < AbstractPhp53Extension
  init
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "3590680b0592d56d02969f595fba6ab30382d6c419081640f47078be7460e4aa" => :el_capitan
    sha256 "a36c7914a536631c71664b68398a1503662dd04d28a8d2033be6465901289cbc" => :yosemite
    sha256 "834742961e5c25a329b9412936b6744af04fc0b9b885f91a1d54839ff595dc91" => :mavericks
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
