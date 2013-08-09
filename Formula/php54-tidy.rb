require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Tidy < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.tidy.php'
  url 'http://www.php.net/get/php-5.4.16.tar.bz2/from/this/mirror'
  sha1 '7e70ba419778a54f5ff9d7de8d6190ca82de3786'
  version '5.4.16'

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
