require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Tidy < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.tidy.php'
  url 'http://www.php.net/get/php-5.5.9.tar.bz2/from/this/mirror'
  sha1 'd5dac90bc09f197b73b5bfcc3ca7dd6187f32e16'
  version '5.5.9'

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file unless build.include? "without-config-file"
  end
end
