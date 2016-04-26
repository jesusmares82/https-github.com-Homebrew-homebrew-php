require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.0.tgz"
  sha256 "b9a642c0ae60cc5e049c169a017cc355bfc0f2478db588b20925eaa63d358e83"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "8142dfbf4e079beaf7732145fdd4bc582095344c105d442f477b88763f0e9c07" => :el_capitan
    sha256 "ac2fb45a9a66f9fe960082dcf755600d445d1fb4a08c29e9f6eafbb232263810" => :yosemite
    sha256 "59f92d16b025c52b665810fdb3af9d9539cf69e70fd0d78af550b3a932531200" => :mavericks
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
