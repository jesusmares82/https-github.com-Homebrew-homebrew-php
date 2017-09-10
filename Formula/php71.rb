require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 21
  bottle do
    sha256 "611726654cfc9958bc4152a6071058cabad33a761f02560b841f7fb22e62954f" => :sierra
    sha256 "40db3a349d225d8f67bc7999121b6f04dc56d7dacb85c783da6b5018a7caa577" => :el_capitan
    sha256 "34c18c453b4d056f1ba241151a3e6e9cdd29e77ae5fdc31a1d1830ae4dd0f255" => :yosemite
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
