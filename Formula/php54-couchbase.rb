require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/couchbase'
  url 'http://pecl.php.net/get/couchbase-1.2.2.tgz'
  sha1 '29cef6c0692a8e3fa3220d62fcf57b442499a2b0'
  head 'https://github.com/couchbase/php-ext-couchbase.git'

  option 'with-igbinary', "Build with igbinary support"
  depends_on 'libcouchbase'
  depends_on 'php54-igbinary' if build.with? "igbinary"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libcouchbase-dir=#{Formula['libcouchbase'].opt_prefix}"
    args << "--enable-couchbase-igbinary" if build.with? 'igbinary'

    safe_phpize

    if build.with? 'igbinary'
      system "mkdir -p ext/igbinary"
      cp "#{Formula['php54-igbinary'].opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
