require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 10

  bottle do
    sha256 "45bcdb816be59b939971e0236c0774b299ff2d1d38dab33c384ec639428ae386" => :high_sierra
    sha256 "c25bc8b358b1890a4a7b0b0419af55ba4267377d8f492a1342334a6187c1b126" => :sierra
    sha256 "919020afd6b2566d7ef30f237b1ed538de3cf67b7990d0832d49cd244f75da4f" => :el_capitan
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
