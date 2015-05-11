require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  include AbstractPhpVersion::Php53Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  # build dependancy needed to fix issue #962
  depends_on 'autoconf' => :build
  depends_on 're2c' => :build
  depends_on 'flex' => :build
  depends_on 'homebrew/versions/bison27' => :build

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
    url "https://gist.githubusercontent.com/alanthing/9b786af22698eda39497/raw/0fcbbff7fe4b05ed7c011730cc80e50bd9123dec/multi-sapi-5.3.29-homebrew.patch"
    sha256 "9d70a202321cd91acb31037dd0c5dcd5dc8fe32f325b8a291388f07e0bbdc533"
  end
end
