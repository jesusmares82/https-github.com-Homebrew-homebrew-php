require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 11

  bottle do
    sha256 "372cc9a03e6622f0c6bcf286bdb31b95bb8fae12e29ea7e16bf97d54441dc981" => :high_sierra
    sha256 "1904b0d61747d30ef0adfa74216107bccebe28fd9a772154e30aca144937d07d" => :sierra
    sha256 "befa06e73d9f66f8dda6d97280147b36bce4f29f61d090009af7fe52fed98746" => :el_capitan
  end

  include AbstractPhpVersion::Php72Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.2"
  end

  def php_version_path
    "72"
  end
end
