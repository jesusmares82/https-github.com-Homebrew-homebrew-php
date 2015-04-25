require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "8361ec3d91a3592a7b37517bd5b0bd7cca141cf0dc7f6e18f8d57b03a6b74ee5" => :yosemite
    sha256 "e1393b7d69b002bd08bc16f4ce3e52d6b563a85c13c7af0b5bada08bd317c872" => :mavericks
    sha256 "6a4b72d098d462461e5cae2bb443d084efc9acd61db8eedfbfd9ec1d85055f0b" => :mountain_lion
  end

  depends_on "php53-igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    mkdir_p "ext/igbinary"
    cp "#{Formula['php53-igbinary'].opt_include}/igbinary.h", "ext/igbinary/igbinary.h"

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
