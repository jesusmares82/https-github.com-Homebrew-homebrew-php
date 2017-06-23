require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 12
  bottle do
    sha256 "fe50ba13b4c532cfbfae91e69739d5117d141a5182fde5dcaf54ea3666f0c45e" => :sierra
    sha256 "d5b55ff54040f778cf1ed3e9cb75b5b31287c015f8b8c851215cecac76662b15" => :el_capitan
    sha256 "e6ec1d49a4030fa0949c304663e6d22d868b76aeaf3cb18ddf4a1aa8bd7016b7" => :yosemite
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
