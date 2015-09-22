require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "738d39c393f6793c1528a787e1f3aa28c06102cdabbbc4376e27907817a7c9a7" => :el_capitan
    sha256 "6291adaa2496ac8a4ecdc0ac6d73f8f7a1a6b6802ac1267980affce44b5584c2" => :yosemite
    sha256 "99b8a68207fd3fa2ffffb3803abd37089176db4247607d1f8267c76eb759d0d1" => :mavericks
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
