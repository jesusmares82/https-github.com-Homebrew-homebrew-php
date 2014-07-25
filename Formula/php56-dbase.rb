require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbase < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/dbase/5.1.0'
  url 'http://pecl.php.net/get/dbase-5.1.0.tgz'
  sha1 'e3740fae3eba6a5d65ca928445f15d58e529201d'
  head 'https://svn.php.net/repository/pecl/dbase/trunk/'

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
