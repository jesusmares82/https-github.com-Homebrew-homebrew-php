require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Memcached < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/memcached'
  url 'http://pecl.php.net/get/memcached-2.1.0.tgz'
  sha1 '16fac6bfae8ec7e2367fda588b74df88c6f11a8e'
  head 'https://github.com/php-memcached-dev/php-memcached.git'

  option 'with-igbinary', "Build with igbinary support"
  option 'with-sasl', "Build with sasl support"
  if build.with? "sasl"
    depends_on "libmemcached" => "with-sasl"
  else
    depends_on "libmemcached"
  end
  depends_on 'php56-igbinary' if build.include?('with-igbinary')

  def patches
    # adapt to libmemcached >= 1.0.9 new instance API (source: paravoid/php-memcached 37069e18ad399a8cc03d5fe9757e1481814ecb44)
    "https://gist.github.com/ablyler/6331007/raw/"
  end

  def install
    Dir.chdir "memcached-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libmemcached-dir=#{Formula.factory('libmemcached').opt_prefix}"
    args << "--enable-memcached-igbinary" if build.include? 'with-igbinary'
    args << "--enable-memcached-sasl" if build.include? 'with-sasl'

    safe_phpize

    if build.include? 'with-igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula.factory('php56-igbinary').opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", *args
    system "make"
    prefix.install "modules/memcached.so"
    write_config_file unless build.include? "without-config-file"
  end
end
