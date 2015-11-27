require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 7
    sha256 "1a45fe1a8aa0e97650029b0d2a229af995292b3176582983c98e4219fb38c82e" => :el_capitan
    sha256 "5f40f6b10ea69881c23a136d266e34640c066bc6465cb3a8d6cdc95a0a9c4d50" => :yosemite
    sha256 "6750bed841cf7bf761da1c0880fb36a9a688d1c4f00b3a14c75338f9a9338352" => :mavericks
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
