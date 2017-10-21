require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 7

  bottle do
    sha256 "64c0f4c025a8011e2270dec9b3c33565bb8a759f18e167c2a599557afaf84c68" => :high_sierra
    sha256 "1037502652a74da620c8ba4bc6c4f2c308210dd59977c4a4d72ba0b8a1f4cbb9" => :sierra
    sha256 "699bd70f7c43e29354133409c466276b1e78486ba769487aea38facea4d8e880" => :el_capitan
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
