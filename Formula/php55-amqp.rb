require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.0.tgz"
  sha256 "b9a642c0ae60cc5e049c169a017cc355bfc0f2478db588b20925eaa63d358e83"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "ae4b8a7bbd4bb376574ee658fe901ea79be8f20a57af81cf82f26fd79ef2778b" => :el_capitan
    sha256 "f9db84746ba774cd39086d6e36c23310f768566c4713aacf0d6075b74a167ad5" => :yosemite
    sha256 "50a0ccda3f09b16791419da9af693c5315c379fe0557d79f6f92838746eb1373" => :mavericks
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
