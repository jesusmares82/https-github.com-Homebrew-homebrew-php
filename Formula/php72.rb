require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 6

  bottle do
    sha256 "375309d15b33f512aa201687c38443e685b5deb0f3ec64bc61d4eff58b68536c" => :high_sierra
    sha256 "165dc5f4b6b0f824d4ff358a843f851ba5676e43cc56bc95e8ada9cbe8e31b57" => :sierra
    sha256 "5ca4f4898265aeaa0f04412766aafb2952d5fbc2989552ac728d7a58ea19c164" => :el_capitan
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
