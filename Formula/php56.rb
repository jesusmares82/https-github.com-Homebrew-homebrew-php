require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "b117b5c0e229eaba33657ecf83fcd4c587f564b30c1b06ed242cf2c24970f224" => :sierra
    sha256 "c04b3da76f4d5588d1afdeae373e92268a836ade3e108aad31891c74389afc54" => :el_capitan
    sha256 "1bd7d3ab6a1630e032cd3df121c417b1b2646f1afb3a501b7a71ff983b9bdf5d" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
