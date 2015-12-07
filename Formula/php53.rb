require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  desc "PHP Version 5.3"
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 1
    sha256 "11d8a78d7ea8d8f96844d16275e9d636c7a92e8500264e167350156f223bf209" => :el_capitan
    sha256 "9eb440e414a3206d90f17455a1f41479b88187d2dce0b3515eac60b35b53c67c" => :yosemite
    sha256 "ba891bb88f8edb2fa25b3921eeeec5429a1743259d7aa87b053c377dce49eb25" => :mavericks
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
    url "https://gist.githubusercontent.com/ablyler/c0264742cc1cca84b708/raw/a5c5c5c689acc003b5db6a9703b4f7d1d586a593/multi-sapi-5.3.29-homebrew.patch"
    sha256 "e21f593ef290851d057ae07b0e513ef188304140912e18a0f28355b801dc2b40"
  end
end
