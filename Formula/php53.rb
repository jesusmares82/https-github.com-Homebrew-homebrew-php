require File.join(File.dirname(__FILE__), 'abstract-php')

class Php53 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.3.25.tar.bz2/from/this/mirror'
  sha1 '8f948bf74a56f0bca70b2f37de6b585af6602b11'
  version '5.3.25'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.3'

  depends_on 'libevent' if build.include? 'with-fpm'

  def install_args
    super + [
      "--enable-zend-multibyte",
      "--enable-sqlite-utf8",
    ]
  end

  def php_version
    5.3
  end

  def php_version_path
    53
  end

end
