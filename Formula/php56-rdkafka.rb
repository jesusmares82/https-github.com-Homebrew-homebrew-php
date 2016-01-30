require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Rdkafka < AbstractPhp56Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-0.9.1.tgz"
  sha256 "59e87fffe14c80d60d8adee12b2887ca3815efd5ae1885da274d8882b4f6404d"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "76d0695bc35be1563edf5713d01d0b5058c95b6009b940499a0a3a9797c31d29" => :el_capitan
    sha256 "d5fabb1e8bc958a7d2fca524c0c80be5d3398e61b39ab9a2d6c7aebe47a90a35" => :yosemite
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
