require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.3.tgz"
  sha256 "c79e52db33bf907dad7da8f350dbdf2937b0679a3dc44fb2a941efb6d4808da9"
  head "https://github.com/pdezwart/php-amqp.git"

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
