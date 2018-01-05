require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 12

  bottle do
    sha256 "fa8adca0854f31aac6d74d70539fabdf2394f3222138eed6a105bafd7a6d3abf" => :high_sierra
    sha256 "2a4696ee084155b981cc7435e2ec3603c8d2e5917365ea85549078794f45070e" => :sierra
    sha256 "3940c952e237dd1a5bd25d58888cff1a5af464a7c6d352a355bf95ee4273e81a" => :el_capitan
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
