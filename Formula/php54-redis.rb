require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    sha256 "c9295478951623fda035f15317b9df9a47682597c09533c05985a59235fb83d4" => :yosemite
    sha256 "1a1e377e5a19ffaa544862c8334abdc977d4880c532c7f8284aac4ce786addad" => :mavericks
    sha256 "5720012b673bf9b5e55a1db9d058c557eb5c8374a0f34102509680efaa003bdf" => :mountain_lion
  end

  depends_on "php54-igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    mkdir_p "ext/igbinary"
    cp "#{Formula['php54-igbinary'].opt_include}/igbinary.h", "ext/igbinary/igbinary.h"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
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

  test do
    shell_output("php -m").include?("redis")
  end
end
