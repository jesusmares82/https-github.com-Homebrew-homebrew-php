require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "b96df68df8f76031a30f0dd1c06d386c3b58b51d2dd1a0d2f8c8888b2df52035" => :sierra
    sha256 "f5b0b5be3b2414268c3c5179ba03d343813b000b8046f6a852c8b79eeba37832" => :el_capitan
    sha256 "d8a5ca885b9dca5119d1331c01da73c9294ea04d17efb9a6d56e5ffde0316912" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
