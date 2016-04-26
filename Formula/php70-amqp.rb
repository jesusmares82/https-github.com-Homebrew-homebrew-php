require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.0.tgz"
  sha256 "b9a642c0ae60cc5e049c169a017cc355bfc0f2478db588b20925eaa63d358e83"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "f097b2a3eabccf8ef5e2e3ccdecf6c79d686b87e73815f8176a5f2bd79cf8b6f" => :el_capitan
    sha256 "91fcc21b03ea53bc51c92adc3bec5837852c41ecd699465cb5a65be8a08e1884" => :yosemite
    sha256 "6e95bb9b6c0e147ff6c3bf436190bc1d33fbd85cb820c78d0d3f086382a8dcfd" => :mavericks
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
