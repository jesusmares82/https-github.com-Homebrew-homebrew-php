require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "d001b1c444d5edd8b0c8a9838dfad6c16f3c21d2e622f26a41678ef8d720c59e" => :el_capitan
    sha256 "a323eb93c4503940b67f4d6c9b7fc3adbd9f429d67d6834441468f80a00ff526" => :yosemite
    sha256 "b269071358750fee4389b12323625c96197ced18020c76fa5e0b9e30237064fb" => :mavericks
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

