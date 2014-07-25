require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/amqp'
  url 'http://pecl.php.net/get/amqp-1.4.0.tgz'
  sha1 '7a08ff1cf0368f2f61db360b3402ed8c45444e85'
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
