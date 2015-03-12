require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redis < AbstractPhp55Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "deb162d5baf67daaf9536a04053056f1a11ccdaa20019b24789b1eccb4077455" => :yosemite
    sha256 "6d8c2383b6a7b40ad36b6c2b89be398f82e2587af5b110fbca3da9bbf28b399d" => :mavericks
    sha256 "a3b2bb4eb4457caac04867e1681d1cfcc53833068ace2fca5ed651543c4dd0a9" => :mountain_lion
  end

  depends_on "php55-igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    mkdir_p "ext/igbinary"
    cp "#{Formula['php55-igbinary'].include}/igbinary.h", "ext/igbinary/igbinary.h"

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
