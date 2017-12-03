require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 11

  bottle do
    sha256 "ec3ecbac3b8807fd3eabaf3748b3d15913f062dd5178a765f7db48fa3099877c" => :high_sierra
    sha256 "93ea1afcb1953070a4f72fe9acdc305f95d1c60e7a6aa6d9eea45b3f5ece6ca3" => :sierra
    sha256 "227d24726e5ee181d8e002bf44ba23fc98aeac725584fc7b2b87371abdd5f788" => :el_capitan
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
