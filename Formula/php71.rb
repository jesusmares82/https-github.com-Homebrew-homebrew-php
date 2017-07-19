require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 19
  bottle do
    sha256 "541a0293c95fcff39e2de353d8fb4f9bbda5ee6fd83d401596d894d493efefeb" => :sierra
    sha256 "7d625a712c9a4818ae02f65b48a8a65b5aa400b6da1189591bdc53e98914c38d" => :el_capitan
    sha256 "3632643946192d3e791ee792081fdb1c9b10fbd01a9f6c129ee643820b02796e" => :yosemite
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
