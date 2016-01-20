require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Amqp < AbstractPhp54Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.1.tgz"
  sha256 "cc24ddf7d4140fa68c127af98a59b72f8b51f73a663816e3e82d676566701d62"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "58b98ec68a0ea7121198aee44e86dce8c5e355b6c72462139d2b646e15da8f26" => :el_capitan
    sha256 "a112885485649f8966c00fad70667f11830f3bf767f4763acb8745f07a52f2e3" => :yosemite
    sha256 "6a9302c06e798ddb6ecd4023ab8d76c4aa38836c80c465197636c6ff7ab8e097" => :mavericks
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
