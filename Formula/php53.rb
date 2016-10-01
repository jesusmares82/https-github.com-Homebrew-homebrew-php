require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  desc "PHP Version 5.3"
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 7

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "35202430186a9a50f75b6c97547b0c6f68b741e975a29b5ad3e6c79a26399341" => :sierra
    sha256 "2ddcb9181c767421f9ce268f5d9e4143f4239bccdc830f13f37004b7d917c555" => :el_capitan
    sha256 "381c72630ff7b02b38fed7d489886f04936fe95a182408fda8d60e5e4a9c6bea" => :yosemite
  end

  # build dependancy needed to fix issue #962
  depends_on "autoconf" => :build
  depends_on "re2c" => :build
  depends_on "flex" => :build
  depends_on "homebrew/versions/bison27" => :build

  depends_on "libevent" if build.with? "fpm"

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
    url "https://gist.githubusercontent.com/javian/6d63097c8c175045aa75ca48a6b8826b/raw/ca7bad287e3af72b83fbb5f7d03186b5da2e65ae/multi-sapi-5.3.29-homebrew.patch"
    sha256 "bdde5c0c1f9d2450d8d9d0a32882e1ee0008d8339eacf919e273e6f7937e7461"
  end
end
