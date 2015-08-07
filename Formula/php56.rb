require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "7fd58d585fa5d2dcece1898ecc620a360bd5b0c4c7d2c89bd34d87bf1a536894" => :yosemite
    sha256 "0fdc443dec0e09586db9635888300e070c5ef063b1d1565225c58778596bd332" => :mavericks
    sha256 "e8604f82816a2fcb174e08dba4e319001e4bd1a2fd3c42d3f5b3ad315751da80" => :mountain_lion
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
