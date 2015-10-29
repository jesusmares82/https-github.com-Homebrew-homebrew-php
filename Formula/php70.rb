require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 5
    sha256 "f2be16ae10cdde0078ac7963545a3375e0c46d2f0dec3a62c7900f731aaedcc7" => :el_capitan
    sha256 "ac23e6125f420b0627f1ffa862b2b24b3599ef1d85ce1cfa1c40975bec29a83b" => :yosemite
    sha256 "56dbcf551c18fa311b146afca8464469dc018ab8df6c1060ba53ec939d665b07" => :mavericks
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
