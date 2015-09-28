require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mosquitto < AbstractPhp54Extension
  init
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "34812952fb528a4dc9f839b0f1db491089d365a21f95efceb5a2c487984acb08" => :el_capitan
    sha256 "61ba44381a33d099155332e10607dd4bf5bcc530dd4a881155480564541ad969" => :yosemite
    sha256 "cec7ed24b23b82aced65038afc0d312ea24141b682ce14526799897098ca6054" => :mavericks
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
