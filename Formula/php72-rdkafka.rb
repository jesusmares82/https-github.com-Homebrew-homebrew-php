require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Rdkafka < AbstractPhp72Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-2.0.1.tgz"
  sha256 "43a3704198f7d8ae23f6ed06d2d28ae4d52bae0f93f484aa5d61d5d60f809eee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "0208c3bda722a5ef315b2f26497f980bb7de3007a77a5e0148396f5c95c08e38" => :sierra
    sha256 "f090bc8eca9558ac62152ed751a0b4bbe5017add68fabe37e1148b9b56a975dc" => :el_capitan
    sha256 "1432216b4cc9b3aea7e417d2b0f8380bdf1f33ee213cc98e2ab16c5dce28f30a" => :yosemite
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
