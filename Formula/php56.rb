require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args << "--enable-zend-signals"
    args << "--enable-dtrace" if build.without? 'phpdbg'
    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    args << "--disable-phpdbg" if build.without? 'phpdbg'
    if build.include? 'disable-opcache'
      args << "--disable-opcache"
    else
      args << "--enable-opcache"
    end
  end

  def php_version
    5.6
  end

  def php_version_path
    56
  end
end
