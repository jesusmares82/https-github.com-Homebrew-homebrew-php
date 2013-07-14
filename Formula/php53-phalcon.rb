require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Phalcon < AbstractPhp53Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/archive/v1.2.1.tar.gz'
  sha1 '5d6f6f5c8d466d0714c37d17078905d00ecd3146'
  head 'git://github.com/phalcon/cphalcon.git', :using => :git
  version '1.2.1'

  depends_on 'pcre'

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir 'build/64bits'
    else
      Dir.chdir 'build/32bits'
    end

    ENV.universal_binary if build.universal?
    ENV.gcc
    ENV['CFLAGS'] = '-O2 -fno-delete-null-pointer-checks -finline-functions -fomit-frame-pointer'

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file unless build.include? "without-config-file"
  end
end
