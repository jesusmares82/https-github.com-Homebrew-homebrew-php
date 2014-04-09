require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Couchbase < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/couchbase'
  url 'http://pecl.php.net/get/couchbase-1.2.1.tgz'
  sha1 '8edf49806eb4f63c8f9e329d3043d304c913541f'
  head 'https://github.com/couchbase/php-ext-couchbase.git'

  option 'with-igbinary', "Build with igbinary support"
  depends_on 'libcouchbase'
  depends_on 'php56-igbinary' if build.with? "igbinary"

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
      cp "#{Formula['php56-igbinary'].opt_prefix}/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
