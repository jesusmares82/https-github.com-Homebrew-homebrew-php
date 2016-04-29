require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 14
    sha256 "e3f6ec4ea4075778cd91216badbbbecdc4ca0d5c2441a334f225956b23566a90" => :el_capitan
    sha256 "a4c4fa53a42cba2f77e30dc34e7be775cb3f1d93c96434396b113c9c935fdc1a" => :yosemite
    sha256 "7a1493fa24a9cc51401fcb73d5383553c1d248d70ea39e2f151d1da94f3984f3" => :mavericks
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






