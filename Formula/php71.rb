require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "1661ab51e2d6a92fd444fa54b2b8ca83aa08b8589cdad1aba9e02146f4260549" => :el_capitan
    sha256 "b11aa248b2c4b92e18555aba87670a30f8e1f783ee125f336a3b878e768a6bc9" => :yosemite
    sha256 "3da11c9cb10b1b9b8847cd9b3582963dea5f47b9884cdb074a7d6c47fd7aa6b6" => :mavericks
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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

