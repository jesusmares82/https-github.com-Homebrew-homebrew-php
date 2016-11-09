require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 10
  bottle do
    sha256 "041724af8ecc24045ea70203e4f35a4646c2bb1f23dd10dda5e2f05526500a12" => :sierra
    sha256 "12c53a053944f749af85c401fbb8917d7dacadafa578bd6be7377fd43ad9f1b9" => :el_capitan
    sha256 "c82da27577c5ac02c229245c099010c5171097f1edc2a155a2be3df724d581bb" => :yosemite
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
