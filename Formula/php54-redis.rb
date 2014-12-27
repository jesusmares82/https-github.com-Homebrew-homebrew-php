require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  homepage 'https://github.com/phpredis/phpredis'
  url 'https://github.com/phpredis/phpredis/archive/2.2.6.tar.gz'
  sha1 'df3d6c9c4d48bf5c1dbcfc64947f7cec828b5014'
  head 'https://github.com/phpredis/phpredis.git'

  option 'with-igbinary', "Build with igbinary support"

  depends_on 'php54-igbinary' if build.with? "igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary" if build.with? 'igbinary'

    safe_phpize

    if build.with? 'igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula['php54-igbinary'].opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end
end
