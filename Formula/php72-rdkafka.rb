require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Rdkafka < AbstractPhp72Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-2.0.1.tgz"
  sha256 "43a3704198f7d8ae23f6ed06d2d28ae4d52bae0f93f484aa5d61d5d60f809eee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision 1

  bottle do
    cellar :any
    sha256 "45c2b570174f731951fec27871f9b704b9cc233eb3bc31514549fcd7d65834b0" => :high_sierra
    sha256 "6697bc95e6201d25e14445266bbce7086db52d274c120ac844a1a137dcae45c6" => :sierra
    sha256 "55c72d6eb640d84069e38de978dd186f664fb6373a329241dfc8b37588b43ca4" => :el_capitan
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
