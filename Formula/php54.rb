require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "b0b91db245f0f995a331effa2b840d3531490883132a1e9617e8f074410e77bf" => :yosemite
    sha256 "a7097258495492c0fe79250bc62c29436c1d17b605a37c465ee1e97477916a92" => :mavericks
    sha256 "28b4c3e9438a4805d68aa2772e5aeef8345a422a7c8e7ade1e913d913749f739" => :mountain_lion
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
