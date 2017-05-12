require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 17
  bottle do
    sha256 "8a1a9099d583f0f6361b0d8897ffd3dc506e4e68ad466f708d443e98c46971a2" => :sierra
    sha256 "826f84c4f68dff499ab33a91f66d0bc03119453d1c9793f832d5a5b40b9d6111" => :el_capitan
    sha256 "89d7fad18b013634a56c9275b09c0f2574dc13453103e22f142e898aeb9f5bab" => :yosemite
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
