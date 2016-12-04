require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Rdkafka < AbstractPhp70Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-2.0.1.tgz"
  sha256 "43a3704198f7d8ae23f6ed06d2d28ae4d52bae0f93f484aa5d61d5d60f809eee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "e2f981352d4a985e17a3932cfc671498e075b68792028fb6855be2539fa9a2e1" => :el_capitan
    sha256 "3d0e050d91b577afcd11d5bf67e423585f583197de7910a7ce9ca3e71dd420d4" => :yosemite
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
