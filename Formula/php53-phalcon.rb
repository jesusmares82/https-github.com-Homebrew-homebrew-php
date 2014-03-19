require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Phalcon < AbstractPhp53Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/archive/1.3.0.tar.gz'
  sha1 '122517118769a6d41bf5f467477c25c495eda31f'
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
