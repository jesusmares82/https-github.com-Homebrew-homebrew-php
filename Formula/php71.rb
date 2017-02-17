require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 13
  bottle do
    sha256 "dd6d9efa8b7ab6c6bb02b3aad69e199033ba15dddd8dd746923a381adf7d1398" => :sierra
    sha256 "bae9149c905f23f95cf0fce984307fef35e27db359b0cf5035f2df90a0800ebc" => :el_capitan
    sha256 "d090d3049f3112b7aae71db985a4fc8f6f6fdd4bef082416f1d731d87f1ac630" => :yosemite
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
