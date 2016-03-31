require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  desc "PHP Version 5.4"
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "f1d0ff8bb1cf268a2a59cfb3006d58b1e0a5a2e28b6d427d0e024b52c5b35ba7" => :el_capitan
    sha256 "6cae868acde1d2d943934ffe4becc88ca686d9a98af1bfda18d04bcf99bab426" => :yosemite
    sha256 "67490dae53bfc769d95f2bae4907471853019b3a90e70581784c23aa1861d42e" => :mavericks
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
