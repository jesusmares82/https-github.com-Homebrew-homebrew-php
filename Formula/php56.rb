require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    rebuild 1
    sha256 "429c6134ed2cbaeb373820f5ea3084766b5fc4b41200a98ad7cbaea64632ee72" => :sierra
    sha256 "d2bace9fedd3412da4a83cd0cf6877a9ee60f6ca9f86056107c7cb7943997bc6" => :el_capitan
    sha256 "78ee949eef8694f0fc34d9715e397c05735de36ad8aeef304110a66d7fc48f7c" => :yosemite
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
