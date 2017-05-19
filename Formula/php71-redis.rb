require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz"
  sha256 "a060fcb7784b9323905cf58557d924a394bb539350bea28d02f910df8ddea1f6"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5da277337a67706a21be26dc4f61c0b6591b3bf5400358ebf2ec545bc5d7f6d4" => :sierra
    sha256 "1d93a38d7f9a38d056b1ff4b4bd3143df4cbf028117395bcb3f7366a43d25d3d" => :el_capitan
    sha256 "f196c66eb950d8c62558c26901e55f8740b0e738787f3123d7888e17cd0f9a4b" => :yosemite
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
