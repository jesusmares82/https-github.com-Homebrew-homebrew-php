require File.join(File.dirname(__FILE__), 'abstract-php')

class Php54 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.4.12.tar.bz2/from/this/mirror'
  sha1 '9e1af30b763ba3de19b68b9b8abde1aae1e5e630'
  version '5.4.12'

  head 'https://svn.php.net/repository/php/php-src/trunk', :using => :svn

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
