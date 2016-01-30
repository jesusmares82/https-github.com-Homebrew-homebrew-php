require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Rdkafka < AbstractPhp55Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-0.9.1.tgz"
  sha256 "59e87fffe14c80d60d8adee12b2887ca3815efd5ae1885da274d8882b4f6404d"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "6dc5cf3e3d0f2eb51900a32245eb4068eb50bd66466acfa433eb75bc732d7ab3" => :el_capitan
    sha256 "7929180dd724ce7e2c7fae745f458470b120cc3dc60da46cb33a350f2c5641c1" => :yosemite
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
