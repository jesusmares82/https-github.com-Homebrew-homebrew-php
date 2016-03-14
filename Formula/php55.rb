require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  desc "PHP Version 5.5"
  include AbstractPhpVersion::Php55Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 5
    sha256 "2c579f48f0f6f982f5f6c4231b68e23b166ac7c8fc5d9c8ffe1a8f57e60a0ad3" => :el_capitan
    sha256 "7892e0e57f0a69b193f8ef7a79ada7cf691da468d3e6c34329ed101b31ee6539" => :yosemite
    sha256 "ac8bfde24907b7569cacb399c7e85e318ed8cd1c43d125d46ad3631d7dd9fad1" => :mavericks
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
    "5.5"
  end

  def php_version_path
    "55"
  end
end



