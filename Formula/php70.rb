require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    sha256 "a16bdc149144a10bf46c5bc4ac7892694e5dbffdf2d9c674cd1e2ad1a43df3ef" => :el_capitan
    sha256 "f426060303b9c6c98488304853684a8787577f52833ebb3b182df814033e2141" => :yosemite
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
