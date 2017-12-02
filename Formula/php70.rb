require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 18
  bottle do
    sha256 "e844e48022dff306a551cab4d421b1ad3652b4637b9b78f75f6a0f1dd8707d82" => :high_sierra
    sha256 "aa6a8f24c82143e47b0dee678e2e42bd79fcf107958daf9dad16c7e36aa068fa" => :sierra
    sha256 "1d6e7c87591a8942fa50ba9724ac029f908fa1272b7a7d5887172c04c2b1588f" => :el_capitan
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
