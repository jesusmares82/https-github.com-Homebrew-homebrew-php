require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "22f0e4bb4e2add47c485b402373af3fc476e89c645b89312933f1dcc59a13fd1" => :yosemite
    sha256 "02865b225d88edd736afc7c449a638c0325df36ae001a9e2f2f7cd2e3b76c362" => :mavericks
    sha256 "442674569deab3e53f1bf0862221168a0b4cf994bf3d7d2067b886e8db17b618" => :mountain_lion
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
