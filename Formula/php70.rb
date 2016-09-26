require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    sha256 "54cc913315c3b6b7cbefbb2b786cb94a21c453f9bbea49a485759e483850b337" => :sierra
    sha256 "83f760d1846f7e243f3f4a8fa8a579f256aa7472edea9407b49101e2eb43543c" => :el_capitan
    sha256 "f3d6e1d380ec158ca08b1fee717d0f24f75d79b1df841be3b860e2f2f2f569b6" => :yosemite
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
