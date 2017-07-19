require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 2

  bottle do
    sha256 "8a9a04930d4c75fe7a647a6a83dabbff03a532cc8729f3e5f5d94b7f05ac7463" => :sierra
    sha256 "9a500f8c8504214d199e6dd45221ef71b48f8995524f030764c6ed0b78f1ae20" => :el_capitan
    sha256 "fde85e8d14be978595eeb5ec3e7db05cf0dd38577a573af5d6c43b22c37d1a11" => :yosemite
  end

  include AbstractPhpVersion::Php72Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.2"
  end

  def php_version_path
    "72"
  end
end
