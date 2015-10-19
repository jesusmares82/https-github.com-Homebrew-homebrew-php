require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 4
    sha256 "5516a6e120c1c3d2e2f2a21c918494f7b704155a50f05abcbf68c807af65cbe2" => :el_capitan
    sha256 "6a264a438eab1a074d09fd2eaa365b6cb09dd12394dd523643e0946a6c022743" => :yosemite
    sha256 "a5a422c4a4016b6d839869a0652b3a408775b614ed70c9b9d05e68b26e6cf34b" => :mavericks
  end

  include AbstractPhpVersion::Php70Defs

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
    "7.0"
  end

  def php_version_path
    "70"
  end
end
