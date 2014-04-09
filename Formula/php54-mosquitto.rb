require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Mosquitto < AbstractPhp54Extension
  init
  homepage 'https://github.com/mgdm/Mosquitto-PHP/'
  url 'http://pecl.php.net/get/Mosquitto-0.2.1.tgz'
  sha1 '0fefee84da5f84dcf78ad0c5deea35f5cce451e4'
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
