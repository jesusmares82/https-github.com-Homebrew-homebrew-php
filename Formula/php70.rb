require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 6
    sha256 "8e8735c8a804cb2bef25746f0bf54f3c19deba10fbbcd5fb5de707b3afc6bd29" => :el_capitan
    sha256 "eb164579908037d893c811ef02b2db08292b352a1be9fcd7ffa6c4b5aebab0d7" => :yosemite
    sha256 "4786a5ffce4937086b882f4b88b385c716258fd37b456c7d29fa22847c4f6a39" => :mavericks
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
