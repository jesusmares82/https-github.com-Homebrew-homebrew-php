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
    revision 2
    sha256 "45c09f65f96bd2e459fe5037e102a7bedb4bec617b664f89d1afb6010953338d" => :el_capitan
    sha256 "6075e1f9d1c9da3ffa52da2a6316134c90982b75f3e44303353544bde25aa399" => :yosemite
    sha256 "7ff18b4253b7c4e9467033bcec416902d74cfe3a9d741bd767b8d9a21a3bbc9c" => :mavericks
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
