require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.1.tgz"
  sha256 "38a92eaef1aa863404170bcd15605f7f78140eeec1ff5be6af65c5b8081e2599"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "4dfadd3a6b0f899d31ba8da21878576c6283fa682f5a878a8768eb49521a37cf" => :sierra
    sha256 "97f81b70dffbc8b3b9286a0c1a056112075250493d46a4ed9795dfa8fa578ceb" => :el_capitan
    sha256 "a4b733b881d88d02aedfef325d361fbb800b9810772f4b0e3f6ac80a70e9d3f1" => :yosemite
  end

  depends_on "rabbitmq-c"

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
