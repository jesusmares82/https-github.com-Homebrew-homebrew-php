require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "af392cc207618d5b8e86274caac6b93c4be9b8176f67f4c6799818569e0926b3" => :el_capitan
    sha256 "d34b148f89393412eab7b206f6ebf3e3c5efe26e4b7a6bad52f02b2cc2108af4" => :yosemite
    sha256 "c3e5ae886d88ce5af7a2b88cdf701e078f7fbdc3c5b14c9e0bcf211087cd2217" => :mavericks
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




