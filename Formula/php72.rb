require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 6

  bottle do
    sha256 "3460363fbff15acbcedbf4a16fee72eb90142578d92c095cba6968000735e590" => :sierra
    sha256 "31c1a22ed2b840d81af032728934a8e35eca19d7e51e7f24b44974b9b86b6e6c" => :el_capitan
    sha256 "ba31b561729e7492d5a1105ee9eb404b548dd0a2c8cd218407a32cf6f23bf6ce" => :yosemite
  end

  include AbstractPhpVersion::Php72Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.2"
  end

  def php_version_path
    "72"
  end
end
