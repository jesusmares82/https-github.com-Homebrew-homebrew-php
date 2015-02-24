require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  include AbstractPhpVersion::Php55Defs
  include AbstractPhpVersion::PhpdbgDefs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "98dad60a170b8b3ca1571586fa8de8040bcd5e73" => :yosemite
    sha1 "ad445d8d1bfe626df6bff9ef96bc4bc31932f03f" => :mavericks
    sha1 "65e8495d9b99bf250cf05041606ae2be37af8186" => :mountain_lion
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
    args << "--enable-zend-signals"
    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    args << "--enable-dtrace" if build.without? 'phpdbg'
    if build.include? 'disable-opcache'
      args << "--disable-opcache"
    else
      args << "--enable-opcache"
    end
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
    "5.5"
  end

  def php_version_path
    "55"
  end
end
