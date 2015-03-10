require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redis < AbstractPhp55Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  option "with-igbinary", "Build with igbinary support"

  depends_on "php55-igbinary" if build.with? "igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary" if build.with? "igbinary"

    safe_phpize

    if build.with? "igbinary"
      mkdir "ext/igbinary"
      cp Formula["php55-igbinary"].opt_prefix+"/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("redis")
  end
end
