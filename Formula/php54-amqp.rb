require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Amqp < AbstractPhp54Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.0beta3.tgz"
  sha256 "4209dbd96355a0610b42a636621b0b2b34169ef64f8067197a1a5a78a5784ac7"
  version "1.6.0beta3"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "fa34965e91a13c84d0db491a1774c46ca8db46050bbe96fa77d591a71a04dd87" => :el_capitan
    sha256 "f6bc1472078d1f5d22b99e283a869e0f6c962e3186f8a21c954c97093ce82f5d" => :yosemite
    sha256 "a66ebec0b368b67baa811ffa5a9b843089ec2218c5bbe5fdd20781cabfc0e012" => :mavericks
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
