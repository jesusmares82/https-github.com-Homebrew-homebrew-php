require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "04f82f00567366231cebdffc4ea0ffa108d29744f783b0b946b87a6c5365ea84" => :yosemite
    sha256 "5b2f55677cef720b203ec0f8f2a05947b155d6151db7edbbdfc2198029e0766a" => :mavericks
    sha256 "1aea47c7dc3408fc3fdb5ae08d12a10420480208279b3dc9686e64088f45dbd9" => :mountain_lion
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
