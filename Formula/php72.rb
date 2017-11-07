require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  init
  desc "PHP Version 7.2"
  revision 9

  bottle do
    sha256 "6f80fb024a57be2c103f039397f06937d9ad48751e19df5b1c0e68e807c35d6f" => :high_sierra
    sha256 "4b2ff96009671bd2e94274233acf92d56d2b130b9f57d2edb01298690e08b82f" => :sierra
    sha256 "9af4113671a99ee2782d583b7fe4a38189072febac66ffea090ee720cbdedc97" => :el_capitan
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
