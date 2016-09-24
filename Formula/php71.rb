require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "8260a3720871b1b16560f8254f9211030261a551cf78360461184787ba282228" => :sierra
    sha256 "aeb0e1b63a0357fc5a58ed8f2a4f07025406b984b05dd5684343bec945c7cd1d" => :el_capitan
    sha256 "0d56dcae8bbd7082f499f03b7c01e65638d243aec75f7a511bfc28632eeabf8c" => :yosemite
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
