require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "edd80af0a8a8af00a8b44ae1564078a4f07d9299fda5c502c85ce19216b7e01f" => :el_capitan
    sha256 "6dd6705e90fe1301c9c3a8d1e369d7f047f2ade8acb368c8d42c7d023d209aa6" => :yosemite
    sha256 "1eea1b9a426d3da8c49d9991e77ed554488de6f28633b6a365c90beba1366158" => :mavericks
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
    url "https://gist.githubusercontent.com/ablyler/c0264742cc1cca84b708/raw/a0a733810be241c22812669757d2294dedca9aad/multi-sapi-5.3.29-homebrew.patch"
    sha256 "e0cabfbeb45d388e4b560459a971f43bcd7d3fb2f1c7d1d39e6ea0eeba8eab83"
  end
end
