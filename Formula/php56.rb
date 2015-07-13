require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "e8b7e05d366d775caced2e3d7b847aca4c064922a90738b83158176adec49e70" => :yosemite
    sha256 "c4f7a8ce7672072285cf31dd1d28864edd5de94b8914c96bd1bbf95decc56105" => :mavericks
    sha256 "b7690993589505bcea7cb16ccbf4ba5541dcfd2e783ec9636f4a9116237756de" => :mountain_lion
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
