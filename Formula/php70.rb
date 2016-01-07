require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 10
    sha256 "3cd0659e067f2f71cb672d9542d4d6fc554396692a5a8168df1149cf770adeb8" => :el_capitan
    sha256 "77e8c0e3d9cdf29606339e523ce0f63c9cb7b2d010a554e720602340eabc3103" => :yosemite
    sha256 "0d9aefa07fb7e5efce11fcc8ea71006a038d6015c876c4ba65090425e11ace8d" => :mavericks
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

