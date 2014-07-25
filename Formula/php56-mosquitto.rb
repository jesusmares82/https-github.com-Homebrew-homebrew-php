require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mosquitto < AbstractPhp56Extension
  init
  homepage 'https://github.com/mgdm/Mosquitto-PHP/'
  url 'http://pecl.php.net/get/Mosquitto-0.2.2.tgz'
  sha1 'b63a5816c89b617d95c0620743edb082a5b0382b'
  head 'https://github.com/mgdm/Mosquitto-PHP.git'

  depends_on 'mosquitto'

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
