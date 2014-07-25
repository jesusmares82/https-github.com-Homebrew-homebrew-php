require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  homepage 'https://github.com/nicolasff/phpredis'
  url 'https://github.com/nicolasff/phpredis/archive/2.2.5.tar.gz'
  sha1 'a2d09bcefb440b2e3fb3b9a08d05810fc3224c9b'
  head 'https://github.com/nicolasff/phpredis.git'

  option 'with-igbinary', "Build with igbinary support"

  depends_on 'php53-igbinary' if build.with? "igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary" if build.with? 'igbinary'

    safe_phpize

    if build.with? 'igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula['php53-igbinary'].opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end
end
