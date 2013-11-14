require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Mcrypt < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.mcrypt.php'
  url 'http://www.php.net/get/php-5.5.6.tar.bz2/from/this/mirror'
  sha1 '02a30f72b1d6876a41b48548d4f95bf2b4761147'
  version '5.5.6'

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
