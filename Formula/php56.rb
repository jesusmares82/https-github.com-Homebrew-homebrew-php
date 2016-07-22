require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 12
    sha256 "f0ac1e2ed470e50464212126237cd14330ddccd7d1327229637f75f385cd9bea" => :el_capitan
    sha256 "a5929d37e32cd3d777d496c14887270bc1511de54df146917bdf7e19f63774bd" => :yosemite
    sha256 "54b66f7c205391deb3073a7820f9c5cd3ec7a92439d35ff3bb85150d53b0ea76" => :mavericks
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




