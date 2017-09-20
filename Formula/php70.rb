require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 15
  bottle do
    sha256 "31421f2c6c555f05840dfbf4cd654e1e188c9e8b1abd7aae438ce9c7f85de153" => :sierra
    sha256 "46a93804f824dff534d325fb40b438e6dacfda3abe0e095403a962791cf4463c" => :el_capitan
    sha256 "c4ad3b0c1a5db2c1025b4774111dcd29f58a61962cc6ce057f55eb1068489001" => :yosemite
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
