require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 14
  bottle do
    sha256 "a82c9a391a2dcc3096a49f93476cedb8a59c1fa648ea72b9350c3e9401d13e57" => :sierra
    sha256 "a457a85b8886171327666b0d4ed6875ce7152afe8e5cc279e331df6e18dce45a" => :el_capitan
    sha256 "c20a09a8b29c9e6ee98bdecf515d46f039312a63bc109f8e8b8568ee506ebe30" => :yosemite
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
