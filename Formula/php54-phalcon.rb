require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/archive/v1.2.3.tar.gz'
  sha1 '431998a4db613c4173301e36053afdfacece5c25'
  head 'https://github.com/phalcon/cphalcon.git'

  depends_on 'pcre'

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir 'build/64bits'
    else
      Dir.chdir 'build/32bits'
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file unless build.include? "without-config-file"
  end
end
