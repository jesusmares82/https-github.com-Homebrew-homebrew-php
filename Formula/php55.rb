require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  include AbstractPhpVersion::Php55Defs
  include AbstractPhpVersion::PhpdbgDefs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
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
    5.5
  end

  def php_version_path
    55
  end
end
