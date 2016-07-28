require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-3.0.0.tgz"
  sha256 "de0e349027ea0821fbfb7f1961226223f3179bb84c6dada515f0145227993f70"
  head "https://github.com/phpredis/phpredis.git", :branch => "php7"

  bottle do
    cellar :any_skip_relocation
    sha256 "c597b1d3f5e5d7ccdc45699efaa29db0f32d2f543898c9b0275bbd22eabf7485" => :el_capitan
    sha256 "a3094b858d8b7447257ef573e2d386d9f0c185bf360b119334ab2abf83d8ade8" => :yosemite
    sha256 "fb59656e95a3a76cd63f86fcb26d5b7a60ce1bd9cfdd17abee2acc50b3069dbb" => :mavericks
  end

  def install
    cd "redis-3.0.0" do
      safe_phpize

      system "./configure", "--prefix=#{prefix}", phpconfig
      system "make"

      prefix.install "modules/redis.so"
    end

    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent

      ; phpredis can be used to store PHP sessions.
      ; To do this, uncomment and configure below
      ;session.save_handler = redis
      ;session.save_path = "tcp://host1:6379?weight=1, tcp://host2:6379?weight=2&timeout=2.5, tcp://host3:6379?weight=2"
    EOS
  end
end
