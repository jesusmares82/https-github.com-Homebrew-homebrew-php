require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  desc "PHP Version 5.5"
  bottle do
    rebuild 1
    sha256 "aacc2f106da8896b982988d552b6fc03a04a31ad6b92e15b9f49e55ce4caa00d" => :sierra
    sha256 "913079f1311d8b7a8f88ad5090940cd28edf1932cd4ddf6837abde74e5c3fbd9" => :el_capitan
    sha256 "3a071954087c498222677a5afeee576289033cfa5b810f93239cf46a940b5b27" => :yosemite
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
      url PHPDBG_SRC_TARBALL
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
