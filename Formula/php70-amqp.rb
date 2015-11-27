require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.0alpha1.tgz"
  version "1.7.0alpha1"
  sha256 "9c123bd4aae1a6b89e2400c7b9e252496ab1bc0dc3db2d6b6dd3051c03b3a43b"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    revision 1
    sha256 "b367b3fd51928945a057c0cb51b96d87273f9c203b0f4d49e5f19b3a2bf9fbc2" => :el_capitan
    sha256 "5b06f2d85d0816b6a4c0555d92a14e43a7f517733259ed301579b947f25e08b2" => :yosemite
    sha256 "5836de23901f32e90a104189f9b6da7000d23a7c191395370fc40ccfac8ebd58" => :mavericks
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
