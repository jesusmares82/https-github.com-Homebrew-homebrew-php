require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 15
  bottle do
    sha256 "95fbf774d7ef0ba9267ac6772910cdea58f90cf50e1a275b3c29d7664f8f4f7c" => :high_sierra
    sha256 "7a7ec711f89dfe96595865e8bb729c3e2fb6cd834100be7e64e80c1990b06d7d" => :sierra
    sha256 "00b217df410af11d346099a011f2bb279a0ad6478f020eeb74da66862a1dc6d8" => :el_capitan
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
