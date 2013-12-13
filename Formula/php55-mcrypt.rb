require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Mcrypt < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.mcrypt.php'
  url 'http://www.php.net/get/php-5.5.7.tar.bz2/from/this/mirror'
  sha1 'f32ccf1a2aa0592e2dcc151c89a7a811e53e0925'
  version '5.5.7'

  depends_on 'mcrypt'

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula.factory('mcrypt').opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file unless build.include? "without-config-file"
  end
end
