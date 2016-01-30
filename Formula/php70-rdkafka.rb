require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Rdkafka < AbstractPhp70Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://github.com/arnaud-lb/php-rdkafka/archive/52efa23813ccc8b524c10cd4239338175ef4a6d6.tar.gz"
  version "0.9.1-52efa23813ccc8b524c10cd4239338175ef4a6d6"
  sha256 "174a68e1fc7afdc02baa20540933bb784ecf9dc4a5c111436007aa75ec11cbd6"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "e2f981352d4a985e17a3932cfc671498e075b68792028fb6855be2539fa9a2e1" => :el_capitan
    sha256 "3d0e050d91b577afcd11d5bf67e423585f583197de7910a7ce9ca3e71dd420d4" => :yosemite
  end

  depends_on "librdkafka"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
