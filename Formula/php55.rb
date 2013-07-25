require File.join(File.dirname(__FILE__), 'abstract-php')

class Php55 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.5.1.tar.bz2/from/this/mirror'
  sha1 'b31b6922cb2796a52be9dc6696f31fcbb20ac916'
  version '5.5.1'

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
