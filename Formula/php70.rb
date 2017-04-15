require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 10
  bottle do
    sha256 "65023f974c4ab7927589e82e0a1edf7839ecb25a9e3bd9f7fcc5a3f94a0d807b" => :sierra
    sha256 "7ab129d5fc136cfa2dbafaf292762d5ebbfd1d6fc970cbaa401bc10f0c51261d" => :el_capitan
    sha256 "bd2ce545f2cb53fa8beb103720044150657bb318a1686741fb6ad0936c7bcd99" => :yosemite
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
