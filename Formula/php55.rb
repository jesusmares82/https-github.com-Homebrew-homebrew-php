require File.join(File.dirname(__FILE__), 'abstract-php')

class Php55 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.5.5.tar.bz2/from/this/mirror'
  sha1 '85b9db72cb6af5612703aec45deba4262eadbb1a'
  version '5.5.5'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.5'

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args + [
      "--enable-zend-signals",
      "--enable-dtrace",
      "--enable-opcache",
    ]
  end

  def php_version
    5.5
  end

  def php_version_path
    55
  end

end
