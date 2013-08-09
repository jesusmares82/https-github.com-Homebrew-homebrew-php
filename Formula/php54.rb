require File.join(File.dirname(__FILE__), 'abstract-php')

class Php54 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.4.16.tar.bz2/from/this/mirror'
  sha1 '7e70ba419778a54f5ff9d7de8d6190ca82de3786'
  version '5.4.16'

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
