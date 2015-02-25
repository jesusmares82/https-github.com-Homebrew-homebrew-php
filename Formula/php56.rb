require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "27f4b0c52c0504a45b4a412c8f4cf36c4ff841c8" => :yosemite
    sha1 "d4492486d86f0c854e1b1866a2896506dc6c7555" => :mavericks
    sha1 "eb694f187b54b1bc03a3ab0c27dc53aa0c23b121" => :mountain_lion
  end

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  def install_args
    args = super
    args << "--enable-zend-signals"
    args << "--enable-dtrace" if build.without? 'phpdbg'
    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    if build.without? 'phpdbg'
      args << "--disable-phpdbg"
    else
      args << "--enable-phpdbg"
      if build.with? 'debug'
        args << "--enable-phpdbg-debug"
      end
    end
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
