require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "d4d0fed5375d3d82f05d5618c40af42a43a6f5f8" => :yosemite
    sha1 "8d52be214ab7a42a743186f451cced81998d9c30" => :mavericks
    sha1 "73e8057786fc3e5d1085658986421a17a81fc8ed" => :mountain_lion
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
