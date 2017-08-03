require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 3

  bottle do
    sha256 "93decb5c8203d75ddb39eb119289c5c8320b10bd467d57b0b7999794eb64c368" => :sierra
    sha256 "33af797989bde8695b2640ec5eb46c8dfa9bba2bd4f846b8bd6dfa1a7a806d04" => :el_capitan
    sha256 "737b01375a2fa4278b960fb2ec50b629d216961f75bd82fc978011dba004c33e" => :yosemite
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
