require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 17
    sha256 "e57d8e0dbd7f275a412e85ac8c658ba9911fa158955cdbf8de8fcd9d3418c871" => :el_capitan
    sha256 "cce9c6980d66f89f582256db4696b6cfb0b2842dcafe6f53fdb04203c4729ab9" => :yosemite
    sha256 "a2a427dda7dcdc13fae03b282dd9b732c154bdd8e54cf3373cdd5f0858e6c6bd" => :mavericks
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









