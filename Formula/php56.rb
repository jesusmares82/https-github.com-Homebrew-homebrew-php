require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "6e52282eefc99158888fe1a0a61d2c678913fb64" => :yosemite
    sha1 "c55247f57739fbdfbc57bd41f72746bf07383921" => :mavericks
    sha1 "8f9688d290cdd3aa971c54cacb2e8c1d52f11150" => :mountain_lion
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
    if build.include? 'disable-opcache'
      args << "--disable-opcache"
    else
      args << "--enable-opcache"
    end
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
