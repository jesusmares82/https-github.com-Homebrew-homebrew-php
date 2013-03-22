require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/tarball/1.0.1'
  version '1.0.1'
  sha1 'c6f8aa8f7afcbbb6a09b64e81a284d7988337b38'
  head 'git://github.com/phalcon/cphalcon.git', :using => :git

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
