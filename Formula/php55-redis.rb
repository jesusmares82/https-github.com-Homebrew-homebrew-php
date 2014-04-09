require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Redis < AbstractPhp55Extension
  init
  homepage 'https://github.com/nicolasff/phpredis'
  url 'https://github.com/nicolasff/phpredis/archive/2.2.4.tar.gz'
  sha1 'e3b66ee2fc64549403f94c687e24ff121d564909'
  head 'https://github.com/nicolasff/phpredis.git'

  option 'with-igbinary', "Build with igbinary support"

  depends_on 'php55-igbinary' if build.with? "igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary" if build.with? 'igbinary'

    safe_phpize

    if build.with? 'igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula['php55-igbinary'].opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end
end
