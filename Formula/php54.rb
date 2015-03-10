require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "e34e01617dd34073036023e5da4e7d18dd22ea3a" => :yosemite
    sha1 "5b61e3c10fe5e0d32ff5d40024a94cc95241a1f5" => :mavericks
    sha1 "856f25a49e3828cd30733f31120c074cc9cda052" => :mountain_lion
  end

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  if build.with? 'phpdbg'
    # needed to regenerate the configure script
    depends_on 'autoconf' => :build
    depends_on 're2c' => :build
    depends_on 'flex' => :build

    resource 'phpdbg' do
      url PHPDBG_SRC_TARBAL
      sha256 PHPDBG_CHECKSUM[:sha256]
    end
  end

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    args << "--enable-dtrace" if build.without? 'phpdbg'

    args << "--enable-zend-signals"
  end

  def _install
    if build.with? 'phpdbg'
      resource('phpdbg').stage buildpath/'sapi/phpdbg'

      # force the configure file to be rebuilt (needed to support phpdbg)
      File.delete('configure')
      system "./buildconf", "--force"
    end

    super
  end

  def php_version
    "5.4"
  end

  def php_version_path
    "54"
  end
end
