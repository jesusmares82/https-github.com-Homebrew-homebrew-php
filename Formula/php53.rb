require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  desc "PHP Version 5.3"
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "477b85e1624db04a22e473c4e3df87c37cee5117648e0289d1ead52a7f140f80" => :el_capitan
    sha256 "00e6f8ebabb682ccb74108bf40d5d64c0fa3ef9cce4a5e9f927a923d737e03c5" => :yosemite
    sha256 "82845a26a11583a78936f7bde1f105bfb79a4945b1eb085b072ce6fd8218818c" => :mavericks
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
