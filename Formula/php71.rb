require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 24
  bottle do
    sha256 "ca5f5c4365f19040291c21778e6970b5c566d36e53312f47a7a51e860dc8880b" => :high_sierra
    sha256 "fee3c6640135118e26713a002e44f948752befb4ecc2202f0881acd4ffaa0b6f" => :sierra
    sha256 "0b199febda47c3725b87201bbaf21d974e9b9fd4badd52e75fe732a0f2a953d7" => :el_capitan
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
