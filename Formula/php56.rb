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
    revision 8
    sha256 "7d2e8fc19a6094cf35d5f6b36c90289f71dbcaeb9894c66fbcd12d01d6979389" => :el_capitan
    sha256 "4bef7fb490c94e34f6b4bd3ecf07f1ef0e927930757188a112d577f17ad9b87a" => :yosemite
    sha256 "b540e74b9ff50897b750bc4505ee2f4dbf696185efe4b9836a6d1ff5467a24b0" => :mavericks
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
