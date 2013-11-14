require File.join(File.dirname(__FILE__), 'abstract-php')

class Php55 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.5.6.tar.bz2/from/this/mirror'
  sha1 '02a30f72b1d6876a41b48548d4f95bf2b4761147'
  version '5.5.6'

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
