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
    sha256 "3b08a56caf7253d8e46e581c8e21936f730fd83026bbe0f74cff04dff48c59b8" => :yosemite
    sha256 "ea359b94027c971036436d37e2b6d01aeae09b74fb1c4cb827874b71aa6db2de" => :mavericks
    sha256 "ee19f627838129b455c1394b73d9be359d7c28b6e54e3d72e794cd609d7c351f" => :mountain_lion
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
    "5.5"
  end

  def php_version_path
    "55"
  end
end
