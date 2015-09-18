require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  include AbstractPhpVersion::Php56Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    revision 1
    sha256 "4fc12ddd4879572a4799824c368dbd77e77a166351a837eba4371e8b7438d1fb" => :el_capitan
    sha256 "1b235218c76ffbb9951667f42fbb185a57c33b541cc019eea15a49e5942ea343" => :yosemite
    sha256 "fd62716322f54b8a8a237ae147c1540937c6ebe594f423f715cde9de13b808ca" => :mavericks
  end

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    if build.without? "phpdbg"
      args << "--enable-dtrace"
      args << "--disable-phpdbg"
    else
      args << "--enable-phpdbg"

      if build.with? "debug"
        args << "--enable-phpdbg-debug"
      end
    end

    args << "--enable-zend-signals"
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
