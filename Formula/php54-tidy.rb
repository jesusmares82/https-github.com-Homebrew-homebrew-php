require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Tidy < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.tidy.php'
  url 'http://www.php.net/get/php-5.4.19.tar.bz2/from/this/mirror'
  sha1 '465f4cd1f8a0fec3c63b79b229bc3893770e2d0b'
  version '5.4.19'

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
