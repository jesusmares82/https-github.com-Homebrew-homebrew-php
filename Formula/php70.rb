require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 6
  bottle do
    rebuild 1
    sha256 "a1f356ab4038cf3753ea98ce4a474d637492afdce4a1e7c723d757908263bdbe" => :sierra
    sha256 "56c09d5bd1784447dea3dc79462b16e708904196b2b31caca0fbe37e9ecf90fe" => :el_capitan
    sha256 "d6aca6fc3065d2ab425524a60b6feb28c91d9c9b61a377bf1354f0cc64995fe8" => :yosemite
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
