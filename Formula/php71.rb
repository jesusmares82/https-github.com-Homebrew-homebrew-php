require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "f9df937bfdadb18582929874076590ca6e65013a497b44eac392b7982871e918" => :el_capitan
    sha256 "5015541f849d8a717d815baae84afbb1832cf502d8a12f9bf5819540f20727cc" => :yosemite
    sha256 "2f6faa73b8513130e770e173326a4b8f990dba4813f5d07e8ef370ccb11b2191" => :mavericks
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
