require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 23
  bottle do
    sha256 "c2c1854448bf7e59f8ea2080f90aef7c322f08b630fb433f2a11e87b0193e31c" => :high_sierra
    sha256 "fddc8cf91c79b780f319e9404c0874ddfa5cfabd7b71f16aa500fcf04102f29d" => :sierra
    sha256 "09b4d127a968d6ad955a7a202e118ae7157591f2cd97a6c8ddf03d00bf4cb8fd" => :el_capitan
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
