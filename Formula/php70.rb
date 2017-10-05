require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 16
  bottle do
    sha256 "07b6a904685c88d1c88a35996c831cb8372c5680c5730b0ff46ed9e440d2e887" => :high_sierra
    sha256 "fd5bdd9b6bf88a6659230d9a85d4cc3f90d9d0144c3da4fb1c97444cbec2c50e" => :sierra
    sha256 "86751709aef4498fc28c5f94e15386604dbd8f6776c3cf5e2d128fc3bd74d0f8" => :el_capitan
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
