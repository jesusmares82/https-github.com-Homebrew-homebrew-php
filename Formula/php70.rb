require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 13
  bottle do
    sha256 "29107d815bbdae02981a1293ca405ffd033e0f38c43bdf83e327d2ca233ee5ec" => :sierra
    sha256 "1c1bfda9f942a958eddda4d70a7483436a5a07307f35c9a3a8c409b75e6f167f" => :el_capitan
    sha256 "476c99d98e0383502e7953262d3318821c042c435ac4e347f250391be68c0d9e" => :yosemite
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
