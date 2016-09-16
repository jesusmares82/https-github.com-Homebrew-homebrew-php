require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    rebuild 1
    sha256 "b3d7372c0749d4a3fb37fbe4ba94d5a33b4163aad102ad8023cc5ce24c67563b" => :el_capitan
    sha256 "13ae5beed43f18aeacd78ed8464b4f4536f6a573429830e1fcfd4ef79657d735" => :yosemite
    sha256 "4e0f8741616b050c1d90c01be0af82cf1778cc73777341f748e084e703381d0a" => :mavericks
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
