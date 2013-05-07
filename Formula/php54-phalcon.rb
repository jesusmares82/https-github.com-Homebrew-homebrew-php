require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/tarball/1.1.0'
  version '1.1.0'
  sha1 '402a1da8fcc9ab67f89da50ecef4510355f6cef6'
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
