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
    revision 5
    sha256 "cd512479f765c3a1a28261b04ebd0c83addf49fa3f8f4eafabce4abb03a50ea5" => :el_capitan
    sha256 "a9d42c171d6e823b71dab4ff70dc48562a4278b0df9dcf2023327d660987e856" => :yosemite
    sha256 "9f9fc4ecc1fcd295c0d1d14f3617da212a707ae18c00c08cbe971323a4747fd7" => :mavericks
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

