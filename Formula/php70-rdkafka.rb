require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Rdkafka < AbstractPhp70Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-3.0.4.tgz"
  sha256 "4cb0a37664810d2a338cf5351e357be7294d99458f76435801e0ed5e328dc5ee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "8dee7976075701a8727db0d2b17a91853c58919dc6e54b9cc528c4816822d489" => :sierra
    sha256 "57628adcfad6476a6ebf488567bd1e86c12c0ae3ee74aaba88c743139d905b2b" => :el_capitan
    sha256 "21abbb2c9f50e019c87391272b2a319560a85b0e88e808dd832e9f17ed016520" => :yosemite
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
