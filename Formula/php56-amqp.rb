require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.0beta3.tgz"
  sha256 "4209dbd96355a0610b42a636621b0b2b34169ef64f8067197a1a5a78a5784ac7"
  version "1.6.0beta3"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "7448af4c667c3f8c5a8cf06c047618158382dba7e9d7247ec065fc33fc7230dc" => :el_capitan
    sha256 "058cfb0c8e156d9b3fa57226192d2a47784ebde641bdb7559e95cee673eff03e" => :yosemite
    sha256 "4bc673ad818e510322270f6cb85f8880878634614c56f8da6e6428df48520750" => :mavericks
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
