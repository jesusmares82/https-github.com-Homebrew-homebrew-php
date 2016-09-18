require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    rebuild 3
    sha256 "30b3a0a5482df5e92edd51a1a537a3ca23708019dc252bab4f4a1152359b1b81" => :el_capitan
    sha256 "67db885143f1c6cea46bfa01a6f5406763c4da6a53828cf0dee2755d366d6028" => :yosemite
    sha256 "a97fb4a1e5b95f62e80ec67364a20254198591b341a73fb03ee151967409c6d0" => :mavericks
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
