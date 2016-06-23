require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 16
    sha256 "81d28f6e60ec555d6a1a6d5fab724df6f1d7acef0db669a35f8cdd26af2bc236" => :el_capitan
    sha256 "c6393f4f8fb0993c1a843302a7c429cef0c685f2ddbf945e660a54c48f731d5f" => :yosemite
    sha256 "865c0033fb4da76b5ac20622e315a07a53949e7c28036f1a167b6d208ebdac4a" => :mavericks
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








