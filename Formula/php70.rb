require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 12
    sha256 "e0ecb120e0683c5c91bb3ef7e9db7eaae3ca0637e94bf9cf6ff43cb398fd8f9c" => :el_capitan
    sha256 "12f5691379e104a4c87c42325a9d71c925568d032ab23e7c9ccfe01fab241f26" => :yosemite
    sha256 "06c84955024d05d48a27a4ee921440751d91c10c4ba94355e41a63441e9c7249" => :mavericks
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



