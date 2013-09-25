require File.join(File.dirname(__FILE__), 'abstract-php')

class Php53 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.3.27.tar.bz2/from/this/mirror'
  sha1 '4f95682940ebe1bc1a93812d593460625a2aae64'
  version '5.3.27'

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
