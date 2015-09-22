require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 2
    sha256 "a3feff0b0b4f31b184160bad9348d149dd8d54b67bebcf281d6a77ba976b13bd" => :el_capitan
    sha256 "176a242ee0f1ee80c8299f593c1204ee2b1987d15c70dc02f6fcdb11f19776d6" => :yosemite
    sha256 "04f37dc8443332fe44f49a52c68a28737fe301e6d65aff782abc7d600ef67ede" => :mavericks
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
