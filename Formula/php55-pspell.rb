require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Pspell < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.pspell.php'
  url 'http://www.php.net/get/php-5.5.3.tar.bz2/from/this/mirror'
  sha1 '3952e6d678164a700296dbdb8e506b8bb80727fb'
  version '5.5.3'

  depends_on 'aspell'

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula.factory('aspell').opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file unless build.include? "without-config-file"
  end
end
