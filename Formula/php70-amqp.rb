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
    sha256 "8b40be19311dab03f4b4b7d17f332ab5b1490ca98258936953ffcc3dd7559936" => :el_capitan
    sha256 "855d75b0eea9b227c3366e87785bb248c8ea34f251d17ece00b182b5481d255f" => :yosemite
    sha256 "ec4fe1b8cafaba4284193adeee8cfef844cc7ebd7aa2bdc6dd5ead7166afc313" => :mavericks
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
