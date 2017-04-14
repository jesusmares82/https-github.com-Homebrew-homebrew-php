require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 16
  bottle do
    sha256 "dbb407debea586b9f8e00f204b599681c064cbcee204aea90ee441f9acb296ce" => :sierra
    sha256 "ca6031afc28786ee88916e44cb26465aedddc22e2aec1998123518a951e37782" => :el_capitan
    sha256 "182807a16b2ec2a27825e9058d96b9e408e7c98195185fe1b8a5b7fc56471116" => :yosemite
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
