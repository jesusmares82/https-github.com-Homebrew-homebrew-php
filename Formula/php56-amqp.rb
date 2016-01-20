require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.1.tgz"
  sha256 "cc24ddf7d4140fa68c127af98a59b72f8b51f73a663816e3e82d676566701d62"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "7860b169f23515d4e2e0d21b1f4351f5f662b0eca65dba905535ef26dcaa38b9" => :el_capitan
    sha256 "7c8d402e0100d56e8b61cb0491ded57890302312ba56b52a5b6a2625bb74f09c" => :yosemite
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
