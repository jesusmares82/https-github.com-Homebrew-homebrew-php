require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "d1b92869adea7213a52751138e18e7d5927ab555cd28603d8318b4ccccd3ff37" => :yosemite
    sha256 "cee0cf87204613bf6f8bb1ea9c4eef5960949060714c6db25050c479d8467b9c" => :mavericks
    sha256 "4fdbfa5fb64fe2f75a4a09aa588c7e20aa8b67fe562b4a276e2a8bb1f7b742ba" => :mountain_lion
  end

  depends_on "php56-igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    mkdir_p "ext/igbinary"
    cp "#{Formula['php56-igbinary'].include}/igbinary.h", "ext/igbinary/igbinary.h"

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
