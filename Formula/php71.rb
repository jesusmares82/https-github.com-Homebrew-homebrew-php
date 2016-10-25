require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "074fcab127df49c77c5edd1221e86e1baa8d2d03ba8fbd301e57ab74ce32b861" => :sierra
    sha256 "68fe2944eb7d7f0279a327edb7a0f4334a2fee636d518638e7230391a3161a86" => :el_capitan
    sha256 "4054d5ea793ff930c031e656f27daba73c3eada45a9a34241d07c59a32a1df5a" => :yosemite
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 9

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
