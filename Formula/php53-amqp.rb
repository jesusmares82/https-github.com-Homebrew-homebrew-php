require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Amqp < AbstractPhp53Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.1.tgz"
  sha256 "cc24ddf7d4140fa68c127af98a59b72f8b51f73a663816e3e82d676566701d62"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "fcd0d205ae8de72f688837de9887a5937818878296d1e468444b3777a286961c" => :el_capitan
    sha256 "657ff589d5f28689e767e47e196bb85de7be7833ac9e385821c4393fa5805917" => :yosemite
    sha256 "82ca3b6033b80dbafd568ad5c1b709a5cb376a0e60c5d197b4f4828c8293b9bc" => :mavericks
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
