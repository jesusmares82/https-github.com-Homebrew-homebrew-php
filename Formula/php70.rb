require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "ef6660aef71771b0d136c91c449f58617d60523ab8824b358b67462bd5fc78d3" => :yosemite
    sha256 "7a7ed44a8b14328e3fc7be194f1549791f6899146f193e182e3810665dbd4c8e" => :mavericks
    sha256 "46b0f3381d7c8cc10f8bd7e5546ef0ace55d2ddbb36596c697bed19402108170" => :mountain_lion
  end

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
    "7.0"
  end

  def php_version_path
    "70"
  end
end
