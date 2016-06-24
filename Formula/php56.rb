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
    revision 11
    sha256 "135b6c3e38ad4f7ab279ab89ff57f9aa1f53ad9f58a2100292d04df4a12681e4" => :el_capitan
    sha256 "498e6049469d28d55dab315fe948f3a266105f4daa9b8f0308c9100d6d21366f" => :yosemite
    sha256 "c1fb6db46f900de7d88613f57590e839a27c79240a7b931f29cc9a163cf427a5" => :mavericks
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



