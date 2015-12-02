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
    revision 1
    sha256 "608a2004585c7a669ceba34bc353ddd2eda3d67d214826c6f2c1e15feb4b8da2" => :el_capitan
    sha256 "32866b80d5db1a9638aa05f86bce5d7a132a044ec42bc527ecdf70a266b6120b" => :yosemite
    sha256 "8ea44548d2849e393da4324a11ed39bcfa8a20649f7a3d5ae7342869e3ade093" => :mavericks
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
