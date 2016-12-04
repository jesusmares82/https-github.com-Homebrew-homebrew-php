require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Rdkafka < AbstractPhp71Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-2.0.1.tgz"
  sha256 "43a3704198f7d8ae23f6ed06d2d28ae4d52bae0f93f484aa5d61d5d60f809eee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "ee5684377bf7c9a902e1d790814f26f0c1bfe9ebde92ea35c73edf0bd737c6f2" => :sierra
    sha256 "e7d2e68ed4aca305bab9c50cc872b7c503cd7855c43959fd7f65810bfa1284d7" => :el_capitan
    sha256 "556fbd4afeef2181143e469f761109bb310cb8a6bb87050bfc53bce97cf63f46" => :yosemite
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
