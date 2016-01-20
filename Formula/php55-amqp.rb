require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.1.tgz"
  sha256 "cc24ddf7d4140fa68c127af98a59b72f8b51f73a663816e3e82d676566701d62"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "7ba73a9ab6f3f1dcc6546e1efeb01b50256fe1c82eea456e31f4eeb9174a5d8b" => :el_capitan
    sha256 "54a8eb8597a598f3449adf8751852594d6d0cf922fef2969628fe64d03da271f" => :yosemite
    sha256 "4f750d168ba4efe22f3edc3e6eda14055bea2b1924d5a9e59987cc7a1c227a80" => :mavericks
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
