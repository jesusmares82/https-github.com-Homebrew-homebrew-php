require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  include AbstractPhpVersion::Php53Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "036c28f79949a9cf1f8c02a0b54c5480b006749d73c42624cf8d8903e03a8e2e" => :yosemite
    sha256 "41c6b7c3546ac1fe8dfc4a9a482ac3fc5be019521d01219165724e402a6a905c" => :mavericks
    sha256 "15bbb007b65b9848e54456f0145f798c7f1362c5d16428030110b8a6f2ed0259" => :mountain_lion
  end

  # build dependancy needed to fix issue #962
  depends_on "autoconf" => :build
  depends_on "re2c" => :build
  depends_on "flex" => :build
  depends_on "homebrew/versions/bison27" => :build

  depends_on 'libevent' unless build.without? 'fpm'

  if build.with? 'phpdbg'
    raise "phpdbg is not supported for this version of PHP"
  end

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

  # Previous Bison and 10.9+ patches, and multi-SAPIs patch (http://pecl.php.net/~jani/patches/multi-sapi.patch) applied
  patch do
    url "https://gist.githubusercontent.com/ablyler/c0264742cc1cca84b708/raw/a0a733810be241c22812669757d2294dedca9aad/multi-sapi-5.3.29-homebrew.patch"
    sha256 "e0cabfbeb45d388e4b560459a971f43bcd7d3fb2f1c7d1d39e6ea0eeba8eab83"
  end
end
