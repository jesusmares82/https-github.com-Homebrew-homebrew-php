require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 12
  bottle do
    sha256 "8eb43129efbc17abaa2183b902e7b1dae682093c4c51ba494b577c65da6292e9" => :sierra
    sha256 "d939149711013b808eee94293b4f7cad1b105510a9c8388bb3860289a443b266" => :el_capitan
    sha256 "863c9207103dbd1e2112f3787502f73f8db86c81e98840bd5f3295ae327625e4" => :yosemite
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
