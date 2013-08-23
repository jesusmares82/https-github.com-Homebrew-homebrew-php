require File.join(File.dirname(__FILE__), 'abstract-php')

class Php54 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.4.19.tar.bz2/from/this/mirror'
  sha1 '465f4cd1f8a0fec3c63b79b229bc3893770e2d0b'
  version '5.4.19'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.4'

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args + [
      "--enable-zend-signals",
      "--enable-dtrace",
    ]
  end

  def php_version
    5.4
  end

  def php_version_path
    54
  end

end
