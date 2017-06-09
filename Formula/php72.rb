require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"

  bottle do
    sha256 "26ab0e2ee3a5374b0e4aff2811715ee9325758264d8c9d9ddf4607379690ba91" => :sierra
    sha256 "e720ad701b9371cd4dbbf7be205e8675e7f4d7d5ebc803d81a9141acf9f8ab52" => :el_capitan
    sha256 "9ed7a4c2df0ccaeeaf7b86ce8f2ce795955f784bd26405b515a81215674fc2c9" => :yosemite
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
