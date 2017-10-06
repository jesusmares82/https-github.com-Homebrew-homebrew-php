require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 21
  bottle do
    sha256 "ed33add0b83006af73159a21536cec72c322d4bb52afc3b6602d9786086ce77f" => :high_sierra
    sha256 "79f1ef591490d3afde2f17a4777049513d4884ad2a13b6be6fba4740e112c89d" => :sierra
    sha256 "a128add5c85a6015f09f850163f7478bc0f9084439dfc69bef224b333aafd51c" => :el_capitan
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
