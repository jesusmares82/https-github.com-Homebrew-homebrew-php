require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Judy < AbstractPhp56Extension
  init
  homepage 'https://github.com/orieg/php-judy'
  url 'http://pecl.php.net/get/judy-1.0.2.tgz'
  sha1 '3051e72a3ef5d05cbe5ba938841dd2bdef36e9b8'
  head 'https://github.com/orieg/php-judy.git'

  depends_on "judy"

  def install
    Dir.chdir "judy-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/judy.so"
    write_config_file if build.with? "config-file"
  end
end
