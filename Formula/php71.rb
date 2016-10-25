require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "b1403a54ff3ea687f26b1f721464585bbae51397b7b9e097bd7571387641df03" => :sierra
    sha256 "857a9ba56c5c15e1cb5c8d07f1cb73cbac93191e1825df6853557a4a42a47346" => :el_capitan
    sha256 "547ba491c8750b3875d864ccb4d135d75b0580a0332890bb0b62054e7fbf9af7" => :yosemite
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 9

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
