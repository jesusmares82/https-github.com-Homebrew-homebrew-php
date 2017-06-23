require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 1

  bottle do
    sha256 "023124efa4776df53e5f2720394961882185d3e7fca5859ba568d56e74c43ab3" => :sierra
    sha256 "45d6fa7b08897d6fff74ff4c83c2890e532289530d5c5726eb83d1dc89670645" => :el_capitan
    sha256 "fcca7a764844eeab60aa192be9ee3fcfd6adee3b858fcbca36476362d0508052" => :yosemite
  end

  include AbstractPhpVersion::Php72Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.2"
  end

  def php_version_path
    "72"
  end
end
