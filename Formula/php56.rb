require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 8

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "47fbfbdd4a1a4c9751a3c77f3697ef09fb10c0276781b0e62d21f68a0db9049b" => :sierra
    sha256 "298e050bdcdfd0db6cf88c114c105be93323a4e12550394766ad97da01dc92e3" => :el_capitan
    sha256 "a176548d9500a9fa31d6c7e37e3f451c5b02928d1e2d10b71b2df0e12c18c248" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
