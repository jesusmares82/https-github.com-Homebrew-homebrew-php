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
    revision 7
    sha256 "1e7aecf50c257a57cd93937d19aef728f5f6a8cfb803afaf77c8b785bfc93229" => :el_capitan
    sha256 "0b7236c6aff651e19b45ee23b0b72f4cb5d3c09e526bffb982331aaf9c5cdd25" => :yosemite
    sha256 "c27a8b46d4d185099d1cb11ce60ce4fad29cca88aeb71d977f4b168b34e66919" => :mavericks
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



