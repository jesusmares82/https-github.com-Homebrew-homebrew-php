require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Amqp < AbstractPhp53Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.1.tgz"
  sha256 "38a92eaef1aa863404170bcd15605f7f78140eeec1ff5be6af65c5b8081e2599"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "0162b1e7bdf19fa14844a2e3e60522bb0a60d9c097064d08e3e8837eda5f9edc" => :sierra
    sha256 "6818c61907617112e58d0d5dba9940de957a565fb9e745d565e1aebad91e6325" => :el_capitan
    sha256 "0aa9877990d32382816eee6f5b24081e5bf718ce9c5e7139d10a3c9cf74e4cdb" => :yosemite
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
