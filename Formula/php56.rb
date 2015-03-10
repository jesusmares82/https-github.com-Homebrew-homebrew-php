require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "143b6d8adcaed25ef03ec733564e5927a3da88dd" => :yosemite
    sha1 "6d2be0184186457b583424a134d08dc5ea12f602" => :mavericks
    sha1 "5e147fe4e5bfd11e2e80594d942970a724a9d67a" => :mountain_lion
  end

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    if build.without? 'phpdbg'
      args << "--enable-dtrace"
      args << "--disable-phpdbg"
    else
      args << "--enable-phpdbg"
      if build.with? 'debug'
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
