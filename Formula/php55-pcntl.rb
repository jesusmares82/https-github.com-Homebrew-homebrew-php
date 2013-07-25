require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.pcntl.php'
  url 'http://www.php.net/get/php-5.5.1.tar.bz2/from/this/mirror'
  sha1 'b31b6922cb2796a52be9dc6696f31fcbb20ac916'
  version '5.5.1'

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
