require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "bc11e0e639d6dee32e31a4ac70e3ee5c8d7b3416c4f2bbc412a42bfec1094c25" => :yosemite
    sha256 "6cc41f371313dbfbe3eeacc272bd0c2deeaa2ec66a03681f057326ee8ac30f0c" => :mavericks
    sha256 "0e60544850355b25982f1aa57ac5ff17ee0a25c44ac8d6c9afc61d1fa66a12be" => :mountain_lion
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
