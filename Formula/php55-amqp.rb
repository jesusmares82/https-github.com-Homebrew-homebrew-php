require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.0beta3.tgz"
  sha256 "4209dbd96355a0610b42a636621b0b2b34169ef64f8067197a1a5a78a5784ac7"
  version "1.6.0beta3"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "3f510c2b7bc41c8d30f6eb7801dceab550901141bdae48364cf5f147e743d0be" => :el_capitan
    sha256 "e2ebc878b52017c6c90666089230f8248edba8f8850267c526bc313596272f33" => :yosemite
    sha256 "5fe6a170e3ca01e8b2dc215728f6bab77ab00d2975529bf970243546d2eea542" => :mavericks
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
