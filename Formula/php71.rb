require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 18
  bottle do
    sha256 "b1c4a67544833a4729766a26b9043d23e219b49aa48347135d638bc8e1064358" => :sierra
    sha256 "80c71b4c72854cdfdc3ecc0f32577fd77cb84c8b8a94b2970e2eecc1a3706082" => :el_capitan
    sha256 "5ba5cbb4c2510bbb53caac4dcbc7859eeb69c4d55b986e521743f71f07d620b7" => :yosemite
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
