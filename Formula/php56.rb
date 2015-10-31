require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 3
    sha256 "14da18c380e36a56b72a94750eadbe12b6f11991f1c45ef0b44f91dc2f64d9a3" => :el_capitan
    sha256 "1ce274e94004e46028286b5a0ed31598272e6bf56eac9f4bfe2e86677b3fe5df" => :yosemite
    sha256 "ed1ea93f1d0954622efca88518bba647630a4dc1a25a9da3ae5d5bd612d3989e" => :mavericks
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
