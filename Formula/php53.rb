require File.join(File.dirname(__FILE__), 'abstract-php')

class Php53 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.3.26.tar.bz2/from/this/mirror'
  sha1 'd2f97da600b640d618a8790dab22b519aa87b056'
  version '5.3.26'

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
