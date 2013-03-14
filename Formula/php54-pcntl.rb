require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Pcntl < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.pcntl.php'
  url 'http://www.php.net/get/php-5.4.12.tar.bz2/from/this/mirror'
  sha1 '9e1af30b763ba3de19b68b9b8abde1aae1e5e630'
  version '5.4.12'

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
