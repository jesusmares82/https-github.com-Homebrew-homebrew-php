require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.0.0.tar.gz"
  sha256 "030997370bb1906793989c89550d9cafd4fa35dccbad7040b2339301aa961dba"
  head "https://github.com/phpredis/phpredis.git", :branch => "php7"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7ef31f81fcdf58c5209b93e029049166aaab19b42fc1c7f575e9f4078cca4e23" => :sierra
    sha256 "b4d095ce7ae9b6b5e189df099f630557e48f4e6a037a230a139e4e00b164b7c0" => :el_capitan
    sha256 "11496ebc40b5fcd4fb9969afdaa7ca877ac7bd6c1df492e3c48288a606b2527e" => :yosemite
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/redis.so"

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
