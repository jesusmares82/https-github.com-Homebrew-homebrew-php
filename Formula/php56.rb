require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 2
    sha256 "edb0a95fc26c3aeb9f33e4a1d6f5ec9a481bd90370dbf81f9ac1f5293332c870" => :el_capitan
    sha256 "191883805ef9ebaf0be07195f8c639e101f3b83bd6181b133c9d6e478df5a3ee" => :yosemite
    sha256 "d9969931f00642b6bdfa4c64d0b52a8d67b1c264dedd03ced69631e124fbeb2a" => :mavericks
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
