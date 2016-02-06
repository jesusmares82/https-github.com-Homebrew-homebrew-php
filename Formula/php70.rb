require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 11
    sha256 "74ec2d97b8740b8a2906fb8d757649d74a8730163152f4d2efd2cc9eaf154aa0" => :el_capitan
    sha256 "cd6dba08ac42a8eb520772a52a8b92872d9d06ed70d1a203e175fba2f66a0614" => :yosemite
    sha256 "75225ada6d5090339f5a4f9222fa318fc10f15b2d893ec185ac23c7c6e2637db" => :mavericks
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


