require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "8e76ce5c0d8de0fb4eb83152f155a184370254ee3ed82df612957c6ba804239b" => :sierra
    sha256 "5ecff23db1f3eecf5890f0bfec22522f94ac941ce92963d5c6abbb9e669f14c3" => :el_capitan
    sha256 "638df6a34b369f8fe2f84f824363f0898d4b90df16874433126409beb809c4ca" => :yosemite
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 8

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
