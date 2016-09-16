require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "f432f9a644ad25b532d96e4c483543ad6cf5bb1e48931bcc2342afbfa57226f0" => :el_capitan
    sha256 "096deba01c0d6727f16e1e401a5e3b6790af6531fb904fbfb202d2d8ed99243b" => :yosemite
    sha256 "0da6fef87a50946677c603b77b132324c950f67df394d26e4d2c6aed6a920e70" => :mavericks
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
