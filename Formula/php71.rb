require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    if build.without? "phpdbg"
      args << "--enable-dtrace"
      args << "--disable-phpdbg"
    else
      args << "--enable-phpdbg"

      if build.with? "debug"
        args << "--enable-phpdbg-debug"
      end
    end

    args << "--enable-zend-signals"
  end

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end

