require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.1.tgz"
  sha256 "38a92eaef1aa863404170bcd15605f7f78140eeec1ff5be6af65c5b8081e2599"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "4fe9749f478cf770e9ac5b58d6d9893735b646c3ea79ce749275210a4d2aee67" => :sierra
    sha256 "46297d80351e4086295304929dba10d0972f1fdc455371f735f6737ea2055f77" => :el_capitan
    sha256 "4ceaf95fbea69e32137689c5f3dc60fbe416e96e5dc8ac07ad117673d197cbd8" => :yosemite
  end

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
