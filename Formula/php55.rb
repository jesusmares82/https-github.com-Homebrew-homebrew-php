require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  desc "PHP Version 5.5"
  bottle do
    sha256 "30c9dfe8a469e66884d8ed869f437e414214f81f5c79502e82981fbd016c81cd" => :sierra
    sha256 "2aa383f9e5f4b525a3755411918a84e8cee988460130787254a96cb3ada566c7" => :el_capitan
    sha256 "81a057325f78004a2175202728a7444c5e4e9957365bae8da5c0e316d3087c10" => :yosemite
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
