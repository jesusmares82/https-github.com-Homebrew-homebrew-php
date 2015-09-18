require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 1
    sha256 "fa111d25b85d7ff9149e0eb9819b9db373ee0a8ea37c63acbf5f0368e38c867d" => :el_capitan
    sha256 "eeffd3771103ef164e4a732068281fbeaee358e594b525c7632fd4a6bb932471" => :yosemite
    sha256 "1b12fb514bd43166fcc8890e22ca17b9f4fc380530a5f9c1de031630d083190f" => :mavericks
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
    "7.0"
  end

  def php_version_path
    "70"
  end
end
