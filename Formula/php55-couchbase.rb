require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Couchbase < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/couchbase'
  url 'http://pecl.php.net/get/couchbase-1.1.5.tgz'
  sha1 '403170dec2770133ac197e2c1768251380b7d38f'
  head 'https://github.com/couchbase/php-ext-couchbase.git'

  option 'with-igbinary', "Build with igbinary support"
  depends_on 'libcouchbase'
  depends_on 'php55-igbinary' if build.include?('with-igbinary')

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libcouchbase-dir=#{Formula.factory('libcouchbase').opt_prefix}"
    args << "--enable-couchbase-igbinary" if build.include? 'with-igbinary'

    safe_phpize

    if build.include? 'with-igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula.factory('php55-igbinary').opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file unless build.include? "without-config-file"
  end
end
