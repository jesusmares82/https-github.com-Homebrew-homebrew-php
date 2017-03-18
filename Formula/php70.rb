require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 9
  bottle do
    sha256 "cd59fba315e64a22b4fd92c452297c386681000ccd20097360bf983ec239e45f" => :sierra
    sha256 "98b94b6edcb4e4cec4b0da88cccb5372c330dfc076bf046c9199303405f69652" => :el_capitan
    sha256 "bd4f733c54f1c09eb362fcfc3503bce89b7978b67219028df8eb3ad03306dc0c" => :yosemite
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
