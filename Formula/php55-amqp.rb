require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Amqp < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/amqp'
  url 'http://pecl.php.net/get/amqp-1.2.0.tgz'
  sha1 '4b0984148d20532bd6a61e8fa2c46a85d55de991'
  head 'http://svn.php.net/repository/pecl/amqp/trunk/'

  depends_on 'rabbitmq-c'

  def install
    Dir.chdir "amqp-#{version}" unless build.build_head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file unless build.include? "without-config-file"
  end
end
