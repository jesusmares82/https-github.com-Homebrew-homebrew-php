require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    rebuild 2
    sha256 "ebde794f8453e3b1a0a831980edee09423cf996c378c91916ac550444aaffb29" => :sierra
    sha256 "a32add88d54ef6ec1855d6cdc7fa287b266410a6b6e3a93a605e95622c19cc82" => :el_capitan
    sha256 "7934928cb2b7a42fcf2ec17f1865391c403ac88996ef2dcae8edef67e8388f70" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
