require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 1
    sha256 "8f494b4062a5506f88a0bb030de7a2604b5b95b9bebd027dc2ba04b3f362ecd3" => :yosemite
    sha256 "15a3a396676978348199e0ff6424cec6050f28ffff1935c59829f338edefd93a" => :mavericks
    sha256 "359030017a66b3865272e59ae623254a3740719527d0d9f16e65bedf017d2104" => :mountain_lion
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
    "7.0"
  end

  def php_version_path
    "70"
  end
end
