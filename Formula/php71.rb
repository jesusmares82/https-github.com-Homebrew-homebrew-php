require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    revision 1
    sha256 "96b4071410af2049cefe51accc5d387cc1d1e73938930abdb253b302c3310fb4" => :el_capitan
    sha256 "4c22b9c95b8138fcd85f977177f00ef1e2ba142a824d3dbf17c1318fc0d3cd9c" => :yosemite
    sha256 "b60c79abf3d74189f3811b97c9ee9eed0e4b05f2eab58a617201a417f5c77b13" => :mavericks
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

