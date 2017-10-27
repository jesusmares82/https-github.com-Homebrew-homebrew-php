require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 17
  bottle do
    sha256 "5957857677dd6fc853586e9a025116de48adccbeb75c67369594effe47260154" => :high_sierra
    sha256 "ff7768f76e916b25cfecf52217c559d41e423f0f7ad1bbb8482cf4d8ca0a97f7" => :sierra
    sha256 "2b3567794310d6611e99ee2748ad1f079698b84b72e0b9d2ca5f8ecd239440ed" => :el_capitan
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
