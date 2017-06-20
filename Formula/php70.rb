require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 12
  bottle do
    sha256 "c07204ffdbc09cbf01c8e045cf138b3966a13a3c3d7cab26f4367766fccb9c0d" => :sierra
    sha256 "ccb19bf75c9e129c11868d66272af4668374369c1793a19b6a83d752fd2f7518" => :el_capitan
    sha256 "e892c0c2720475e3ec98e07dd9ba140b841918b3f630cc0b6dea510f864d2842" => :yosemite
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
