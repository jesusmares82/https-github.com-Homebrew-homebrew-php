require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Rdkafka < AbstractPhp53Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-1.0.0.tgz"
  sha256 "3a8957c618f9f4093c8258621841c543270f4c4cbfd8ee687ca1dc270b244f87"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "321c4e4048f7d6e8167f5f80e2465b3e15494d4e5702fcffc40939b672ec3b06" => :el_capitan
    sha256 "eb95d3320882e47e4e395f59c3c914843816a1b4ade686587fde81e4fa53b9d1" => :yosemite
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
