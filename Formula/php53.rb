require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  include AbstractPhpVersion::Php53Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "146e013439c6e831cbe749501b5c05e15ecd6f6c283b1240e1e37ffe7304b264" => :el_capitan
    sha256 "27f30057e84ef8f1167b61d348be08b5734ddaa3725c633f332ab63a5c53b8e6" => :yosemite
    sha256 "3df31e6e48d221897d8837c8bb327601037aa0b6567b970497acdc3c2552c484" => :mavericks
  end

  # build dependancy needed to fix issue #962
  depends_on "autoconf" => :build
  depends_on "re2c" => :build
  depends_on "flex" => :build
  depends_on "homebrew/versions/bison27" => :build

  depends_on 'libevent' unless build.without? 'fpm'

  option 'disable-zend-multibyte', 'Disable auto-detection of Unicode encoded scripts'

  def install
    # files need to be regenerated to fix issue #962
    Dir.glob("Zend/zend_{language,ini}_parser.{c,h}").each { |file| rm file }
    super
  end

  def install_args
    args = super
    args << "--enable-zend-multibyte" unless build.include? 'disable-zend-multibyte'
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
