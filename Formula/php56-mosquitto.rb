require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mosquitto < AbstractPhp56Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    revision 1
    sha256 "a16fdda4fa23cbd9b8ecf7b029d3fec62e9ec0591d65b7159f172d1a981037cb" => :el_capitan
    sha256 "c29e8a565293f6519a749ee674c3c569ab84c6bba3894da28bb7b420f1f65647" => :yosemite
    sha256 "478d267893a49fba086e3a1dd9f899b95b14e5a639c6280e0ff9f83a703bcb06" => :mavericks
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
