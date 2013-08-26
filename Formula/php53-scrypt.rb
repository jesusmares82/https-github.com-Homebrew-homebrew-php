require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Scrypt < AbstractPhp53Extension
  init
  homepage 'http://github.com/DomBlack/php-scrypt'
  url 'https://github.com/DomBlack/php-scrypt.git', :tag => 'v1.2'
  head 'https://github.com/DomBlack/php-scrypt.git'
  version '1.2'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "export CFLAGS='-arch i386 -arch x86_64'"
    system "./configure", "--prefix=#{prefix}", "--enable-scrypt",
                          phpconfig
    system "make"
    prefix.install %w(modules/scrypt.so)

    write_config_file unless build.include? "without-config-file"
  end
end
