require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  desc "PHP Version 5.3"
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 2
    sha256 "cc9938478cde2f3be1990ca394d1bfef038099b1218955c21b151c6ba32b8832" => :el_capitan
    sha256 "0a8d39a6196917c68d1c2bcb45f3d86782a91afa4197261a0067d9357e352347" => :yosemite
    sha256 "835da91e6edc95b20dd2ee1073f6f799c0be64e0a8cde4277517ea88d5f74a69" => :mavericks
  end

  # build dependancy needed to fix issue #962
  depends_on "autoconf" => :build
  depends_on "re2c" => :build
  depends_on "flex" => :build
  depends_on "homebrew/versions/bison27" => :build

  depends_on "libevent" unless build.without? "fpm"

  option "disable-zend-multibyte", "Disable auto-detection of Unicode encoded scripts"

  def install
    # files need to be regenerated to fix issue #962
    Dir.glob("Zend/zend_{language,ini}_parser.{c,h}").each { |file| rm file }
    super
  end

  def install_args
    args = super
    args << "--enable-zend-multibyte" unless build.include? "disable-zend-multibyte"
    args << "--enable-sqlite-utf8"
  end

  def php_version
    "5.3"
  end

  def php_version_path
    "53"
  end

  # Previous Bison and 10.9+ patches, and multi-SAPIs patch (https://pecl.php.net/~jani/patches/multi-sapi.patch) applied
  patch do
    url "https://gist.githubusercontent.com/javian/bfcbd5bc5874ee9c539fb3d642cdce3e/raw/bf079cc68ec76290f02f57981ae85b20a06dd428/multi-sapi-5.3.29-homebrew.patch"
    sha256 "3c3157bc5c4346108a398798b84dbbaa13409c43d3996bea2ddacb3277e0cee2"
  end
end

