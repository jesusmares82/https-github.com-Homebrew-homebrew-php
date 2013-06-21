require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Amqp < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/amqp'
  url 'http://pecl.php.net/get/amqp-1.0.10.tgz'
  sha1 '7bfcbc78f9bc6ad58abada45b0c833e7006e1424'
  head 'http://svn.php.net/repository/pecl/amqp/trunk/', :using => :svn

  depends_on 'rabbitmq-c'

  def install
    Dir.chdir "amqp-#{version}" unless ARGV.build_head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file unless build.include? "without-config-file"
  end
end
