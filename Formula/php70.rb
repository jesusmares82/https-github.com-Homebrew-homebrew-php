require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 11
  bottle do
    sha256 "527ee71ab2782cdace2385dcb2fc4c579976971c8cbb76d087ef87d8b21b1924" => :sierra
    sha256 "71c6890f6d1c51aa46df5632fc7c51c44e2cb32a242006cf7feddaeb9494bbd6" => :el_capitan
    sha256 "ea5ff6d59b505143736d66c37b73002cf1fca8f8fffaebe95a75d568e18ea0db" => :yosemite
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
