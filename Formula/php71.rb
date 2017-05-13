require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 17
  bottle do
    sha256 "5cb5d5383ea653e6000f83e035f4abbe1ecab27045f833e20a54813585141f7f" => :sierra
    sha256 "3e8453247379539c98b57fcd43043c3840177d8188141b76865b0533363a9b97" => :el_capitan
    sha256 "e314207c0d752ffe4b5b3b27eb7d34156092a4e1660c946507b196193408815f" => :yosemite
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
