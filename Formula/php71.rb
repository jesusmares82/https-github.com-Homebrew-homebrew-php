require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 13
  bottle do
    sha256 "6be936cc2ccbf1e6b553d5f5e98b90b640d176d7551b748a47fd2e91c64cab81" => :sierra
    sha256 "10889689d1feff416660bd4873dd509b9f50128245a76a53775d6d4e0a231bc6" => :el_capitan
    sha256 "fe1d58ece876ec8bf1d984822db441e4ac5580cf46a065fd0d1e8cb8a1d2ddd6" => :yosemite
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
