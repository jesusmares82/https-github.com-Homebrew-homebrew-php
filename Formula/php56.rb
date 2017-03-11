require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "d4aa1aa72bc6aa601aaf294ea78ccaaa7feb9efb3f82160b0319daed0a239d5c" => :sierra
    sha256 "38a8a5461fff53d9425fd20f66f007648fbb62ba3c93df32b24be63d82ebab43" => :el_capitan
    sha256 "f473fc257dee0024e87da0ea9cb70da86c99991966fd14d3d8b3fc18ac2804ee" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
