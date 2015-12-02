require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mosquitto < AbstractPhp55Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "ad23a1cb0f716d386b5cb68892e0ce65911ce39b350a139b2e88dda606103d83" => :el_capitan
    sha256 "866427f86c538afbe5d7ef47f38ec7bf180269e4aa81babd5578b1f1465f2ae7" => :yosemite
    sha256 "5af0611da121646d289cfdfa02c92618e30b1d449e1a99e1ebcee3a0bc4d7479" => :mavericks
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
