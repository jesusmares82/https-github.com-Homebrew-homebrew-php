require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 13

  bottle do
    sha256 "e60d5ee36a77c2106d892d9088af9bc0c0e77fa84eef1b5fdb517718de9dfd3f" => :high_sierra
    sha256 "2b12a433ec7574c65ce81d7774d5e80b9d96aa44597277ece056396146af1c54" => :sierra
    sha256 "68410fa4d3968bf8abbb452d2da13eaaa72b95ac344a0cd751ee67a9fce933d9" => :el_capitan
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
