require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 8
    sha256 "de7e75e6dc74bfd5b1528b037467afda3ac0b11b24777a63be8c96651b296137" => :el_capitan
    sha256 "19e2e8f0ad91dd2620a4bdb528b09c966b475c039b10fc1ffbe8d3b230b527bb" => :yosemite
    sha256 "1f02533d1333454cf475dd6ffb5ad5846e00ae9b24609afca2ab237dcd182367" => :mavericks
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
