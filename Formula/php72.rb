require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 4

  bottle do
    sha256 "18cf5e40ae1dd83fcfa781335c8da18b7af2b0ffe82ab9145c08949d331d2659" => :sierra
    sha256 "6083eb9b378d729cca5a5d862c9effc9a0cc04405c99e1711eab93e712dd7061" => :el_capitan
    sha256 "ca582ff4f9c5c4516c2ba7c6ac9f76f014caa027c1d0df47d9e013353dba3376" => :yosemite
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
