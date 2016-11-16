require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 6
  bottle do
    sha256 "8776a2afcd7e299196eea0948308a2d42d58ec8ffe3166cba3452936438aa170" => :sierra
    sha256 "df138f344703fa4c18154bf9bf8d9395bf3d23c477344e9ec1fd32a1d8754921" => :el_capitan
    sha256 "7eb06f8ebb62c5b347c95f0eee5a020ff99d67ece3e073a8a0183b3caefef520" => :yosemite
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
