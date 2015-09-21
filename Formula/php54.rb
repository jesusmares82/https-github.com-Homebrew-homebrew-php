require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 1
    sha256 "d1abbbd3335a39d6e30670b7e8ee363bc95ad74d9613c8bba9e05a76b3642ab2" => :el_capitan
    sha256 "b2180a0679c88c7e4d16d2c34817e69502c4596676284c34f6ede7fdf29a95b3" => :yosemite
    sha256 "c9701665bee73cb288a4c44c1ed2304d7e9d1821f34b5c741473ccdc93b78c9d" => :mavericks
  end

  if build.with? "phpdbg"
    # needed to regenerate the configure script
    depends_on "autoconf" => :build
    depends_on "re2c" => :build
    depends_on "flex" => :build

    resource "phpdbg" do
      url PHPDBG_SRC_TARBAL
      sha256 PHPDBG_CHECKSUM[:sha256]
    end
  end

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    args << "--enable-dtrace" if build.without? "phpdbg"

    args << "--enable-zend-signals"
  end

  def _install
    if build.with? "phpdbg"
      resource("phpdbg").stage buildpath/"sapi/phpdbg"

      # force the configure file to be rebuilt (needed to support phpdbg)
      File.delete("configure")
      system "./buildconf", "--force"
    end

    super
  end

  def php_version
    "5.4"
  end

  def php_version_path
    "54"
  end
end
