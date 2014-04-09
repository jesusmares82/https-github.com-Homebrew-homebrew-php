require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Amqp < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/amqp'
  url 'http://pecl.php.net/get/amqp-1.3.0.tgz'
  sha1 'c8174e86846363e12c3e4c9898993ca088b4279e'
  head 'http://svn.php.net/repository/pecl/amqp/trunk/'

  depends_on 'rabbitmq-c'

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
