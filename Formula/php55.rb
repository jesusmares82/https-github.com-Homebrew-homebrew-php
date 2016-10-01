require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  desc "PHP Version 5.5"
  bottle do
    sha256 "525f48bf4f646e4d3dcaafde39244430535fbd25b8e1343cb2e1d56182fd9761" => :sierra
    sha256 "e6d4f97dbcceadc77ac2db1d413f136c72ed3c990abc33e899a3e1bbc92d2f35" => :el_capitan
    sha256 "038ffb53cc9a58b966f986a09103bf8a8b3343b73495b7ae9d3f21550edfc8e4" => :yosemite
  end

  include AbstractPhpVersion::Php55Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 11

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

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
    "5.5"
  end

  def php_version_path
    "55"
  end
end
