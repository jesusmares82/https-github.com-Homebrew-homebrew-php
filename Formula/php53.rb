require File.join(File.dirname(__FILE__), 'abstract-php')

class Php53 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.3.23.tar.bz2/from/this/mirror'
  sha1 'fe9d84ada4747629f31051f9c689629261558056'
  version '5.3.23'

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
