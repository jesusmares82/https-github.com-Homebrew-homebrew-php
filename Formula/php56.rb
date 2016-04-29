require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 9
    sha256 "f7da59f6129a53186375abf8ab6bc5777fb174f4f62bb33f26c91ecd47260ad3" => :el_capitan
    sha256 "1c12c64717597fc7d7830dd14bb35e87136c29223cd7393a7ba0f6983955344c" => :yosemite
    sha256 "4a5d1b0e7144a1b927a5a7b69bb4f1be15054de9ea53545e42ed035fde5b6455" => :mavericks
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
    "5.6"
  end

  def php_version_path
    "56"
  end
end

