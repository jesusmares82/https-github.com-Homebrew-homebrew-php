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
    sha256 "c531f91960c1604ed555f38f4b3144f698e0fa9b14412535844635fdfe1b9002" => :high_sierra
    sha256 "fa8cd4b3dbd746331b18b72665b04b855f37479096db2abf2ce65113125e7f9e" => :sierra
    sha256 "691dade11f52e6bdd083e2766b152e053d33d2a17c4b689f96595a1b0986d04f" => :el_capitan
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
